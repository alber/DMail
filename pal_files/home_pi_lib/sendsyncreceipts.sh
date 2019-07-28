#!/bin/bash


#
#  REQUEST REMOTE-STATION Messages Pending IS_RECEIVED confirmation, for this PALCarrier Home or Away station_ids (as final_destination_id)
#
unconfmessages=$(curl -s 192.168.199.1:3000/messages/outbound_unconfirmed/$1)
if [ -z "$unconfmessages" ] 
then 
  echo "STATION has NO queries on Pending Message status"
else

  readarray -t unconfmessarr <<<"$unconfmessages"

  #
  #  FOREACH Message Pending 
  #
  unconfmesscount=${#unconfmessarr[@]}
  loopit=0
  while [[ $loopit -lt $unconfmesscount ]]
    do
     
      #
      #  PARSE Pending Message returned as $messageid and $messagejump
      #
      messagerec="${unconfmessarr[$loopit]}"
      IFS='|'
      read -ra messagearr <<<"$messagerec"
      messageid="${messagearr[0]}"
      messagejump="${messagearr[1]}"
      echo "CHECKING Message $messageid with jump status $messagejump against Local Records"

      ###
      ### CHECK LOCAL-ONBOARD DB for jump and is_received Status on matching Pending Message
      ###
      airrec=$(sqlite3 Public/palstation/db/development.sqlite3 "SELECT id,jump,is_received,is_sent,final_destination_id FROM messages WHERE id=$messageid AND jump!=$messagejump")
      if [ -z "$airrec" ]
      then
        # do nothing, no updateable records that merit post to station found.
        echo "NOTHING to update on ATG Receipts front." 
      else

        read -ra airrecarr <<<"$airrec"
        airjump="${airrecarr[1]}"
        airreceived="${airrecarr[2]}"
        #if [ "$airreceived" -eq 1 ]  ### todo: condition should encompass midway destination_id related updates in jump indicator not just finaly_destination_id related is_received.
        if [[ "$airreceived" -eq 1 ||  "$airjump" -ne "$messagejump" ]]
        then
          ###
          ### POST for update to Messsage with is_received=1 and jump=airjump
          ###
          postresultraw=$(curl -s -o /dev/null -w "%{http_code}" -d "_method=patch" -d "message[is_received]=$airreceived" -d "message[jump]=$airjump" -d "commit=Update Message"-H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' http://192.168.199.1:3000/messages/$messageid.json)
          read -ra postresult <<<"$postresultraw"
          resultcode="${postresult[1]}"
          if [ "$resultcode" -eq 201  ]
          then
            echo "UPDATED REMOTE-STATION DB With up to date IS_RECEIVED and JUMP info on Message $messageid ."
          else
            echo "FAILED to update REMOTE-STATION DB for is_received and jump up to date status on Message $messageid ."
            echo -e "\r\n * * * \r\n" >> /home/pi/airbound_failsafe.log
            date >> /home/pi/airbound_failsafe.log
            echo -e "\nTRIED FOLLOWING COMMAND BUT FAILED: \r\n" >> /home/pi/airbound_failsafe.log
            echo 'curl -s -o /dev/null -w "%{http_code}" -d "_method=patch" -d "message[is_received]=1" -d "message[jump]='"$airjump"'" -d "commit=Update Message"-H "Content-Type: application/x-www-form-urlencoded" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3" http://192.168.199.1:3000/messages/'"$messageid"'.json'  >> /home/pi/airbound_failsafe.log
            echo "DUMPED command to local log as a FailSafe."
          fi  #end resultcode check for 201
        fi  #end is_received on local sql record is 1 check

      fi  #end if airrec void check
      ((loopit=loopit + 1))
    done #end while loop

fi  #end unconfmessages void check
