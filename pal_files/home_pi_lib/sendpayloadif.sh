#!/bin/bash

isdocking=$(./isdocking.sh)

if [ $isdocking -eq 1 ]
then
  ###
  ### FETCH StationID from Station IF isDocking 
  ###
  stationid=`curl -s http://192.168.199.1:3000/stations/identity`
  echo "This Pal IS_DOCKING on Station with StationID $stationid "

  ###
  ###  UPDATE ANY Up-To-Date Receipts for IS_RECEIVED that this Station maybe wanting to know on Pending IS_SENT messages to a Station this PAL may have visited.
  ###
  homestationid=$(sqlite3 Public/palstation/db/development.sqlite3 "SELECT service_home_id FROM stations WHERE is_me=1")
  awaystationid=$(sqlite3 Public/palstation/db/development.sqlite3 "SELECT service_away_id FROM stations WHERE is_me=1")
  ./sendsyncreceipts.sh "$homestationid"
  ./sendsyncreceipts.sh "$awaystationid"

  ###
  ### FIND LOCAL Messages intended to arrive at this Station we are currently Docking
  ### 
  outboxmsgs=`sqlite3 -separator '|' ~/Public/palstation/db/development.sqlite3 "select quote(id),quote(body),quote(is_received),quote(is_sent),quote(jump),quote(destination_id),quote(final_destination_id),quote(author) from messages where destination_id=$stationid and is_received=0"`
  if [ -z "$outboxmsgs" ]
  then
    echo "DID NOT FIND Air-To-Ground (ATG) Messages for this Station ONBOARD"
  else
    readarray -t outboxmsgsarr <<<"$outboxmsgs"
    outboxcount=${#outboxmsgsarr[@]}
    echo "FOUND $outboxcount Air-To-Ground (ATG) Messages for this Station."

    ### 
    ### FOREACH Message in above Outbox Message Collection, do the following
    ###
    loopit=0
    while [[ $loopit -lt $outboxcount ]]
    do
      ###
      ### PARSE this SQL record from the Outbox into id,text pair and use that to perform a curl POST request to Station
      ### 
      messagerec="${outboxmsgsarr[$loopit]}"
      IFS='|'
      read -ra messagearr <<<"$messagerec"
      messageid="${messagearr[0]}"
      messagetext="${messagearr[1]}"
      messagereceived="${messagearr[2]}"
      messagesent="${messagearr[3]}"
      messagejump="${messagearr[4]}"
      messagedest="${messagearr[5]}"
      messagefinaldest="${messagearr[6]}"
      messageauthor="${messagearr[7]}"
      postresult=$(curl -s -o /dev/null -w "%{http_code}" -d "message[id]=$messageid" -d "message[author]=$messageauthor" -d "message[format]=text" -d "message[body]=$messagetext" -d "message[is_received]=$messagereceived" -d "message[is_sent]=$messagesent" -d "message[jump]=$messagejump" -d "message[destination_id]=$messagedest" -d "message[final_destination_id]=$messagefinaldest" -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' http://192.168.199.1:3000/messages.json)
      sleep 1s
    
      ### 
      ### IF POST was successful UPDATE the LOCAL Record and mark as Received (is_received=true)
      ###
    
      if [ "$postresult" -eq 201 ]
      then
        echo "POSTED ATG Successfully to REMOTE-STATION DB."
        ### ACK FLAGs with or without IS_RECEIVED, depending on final_destination_id matching station_id
        ackreceived=""
        if [ "$stationid" -eq "$messagefinaldest" ]
        then
          ackreceived=",is_received=1"
        fi
        isreceiptdone=$(sqlite3 ~/Public/palstation/db/development.sqlite3 -cmd "UPDATE messages SET jump=$stationid$ackreceived WHERE id=$messageid" "SELECT jump FROM messages WHERE id=$messageid")
        if [ "$isreceiptdone" -eq "$stationid" ] ### TODO: confirm if 1 exit status or 1 affected row-count
        then 
          echo "ACK FLAG SAVED  for ATG Message on LOCAL-ONBOARD DB as JUMP=StationID." 
        fi
      fi

      ((loopit=loopit + 1))
    done  # end foreach outbox message loop.
  fi  #end outboxmsgs void check

  ###
  ### GET REMOTE(Station) Messages intended to come onboard for transport in this PALstation 
  ### NOTE: after much struggle to parse JSON into BASH array, CURL format is now received
  palcarrierid="$homestationid"    
  if [ "$homestationid" -eq "$stationid" ]  #were docking home, give me messages for away_station
  then
    palcarrierid="$awaystationid"
  else                                      #were docking away, give me messages for home_station
    palcarrierid="$homestationid"
  fi
  curlcmdsraw=$(curl -s 192.168.199.1:3000/messages/outbound/$palcarrierid)
  if [ -z "$curlcmdsraw" ]
  then
    echo "DID NOT FIND any Ground-To-Air (GTA) Messages waiting on Station to come ONBOARD"
  else
    readarray -t curlcmdsarr <<<"$curlcmdsraw"
    cmdcount=${#curlcmdsarr[@]}
    cmdit=0
    echo "FOUND $cmdcount Ground-To-Air (GTA) Messages waiting to board." 
    while [[ $cmdit -lt $cmdcount ]]
    do
      cmdresult=$(eval ${curlcmdsarr[$cmdit]})
      if [ "$cmdresult" -eq 201 ]
      then
        echo "SAVED GTA Message to LOCAL-ONBOARD DB."
        gtahshake=$(curl -s -o /dev/null -w "%{http_code}" 192.168.199.1:3000/messages/outbound_confirmed/$palcarrierid)
        if [ "$gtahshake" -eq 201  ]
        then
          echo "CONFIRMED this GTA Message IS_SENT on REMOTE-STATION DB." 
          ### ... finally extract ID from curl command and UPDATE local Record for is_sent=true, deterministic.
          cvar=$(echo ${curlcmdsarr[$cmdit]})
          cshortvar=$(echo ${cvar#*=})
          cidvar=$(echo ${cshortvar:0:13})
          echo "Local Update REcord with ID: $cidvar"
          localissentqueryresult=$(sqlite3 ~/Public/palstation/db/development.sqlite3 "UPDATE messages SET is_sent=1 WHERE id=$cidvar")
          echo "CONFIRMED this GTA Message as IS_SENT on LOCAL-ONBOARD DB."
        else
          echo "FAILED to confirm GTA Messges is_sent on REMOTE-STATION DB." 
        fi
      else
        echo "${curlcmdsarr[$cmdit]}" >> /home/pi/inbound_failsafe.log
        echo "FAILED TO SAVE GTA Message into LOCAL-ONBOARD DB. Saved commands with raw messages to local .LOG as failsafe measure." 
      fi
      ((cmdit=cmdit+1))
    done  # end while curl specs received loop
  fi  # end actual curl cmds received from station Void check
fi ### end isdocking event check
