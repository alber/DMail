class Flightplan < ApplicationRecord
  has_many :waypoints

  after_validation :fetch_wforecast, on: [ :update ]

private
  def fetch_wforecast
    puts "*** HELLO WEATHER API COMMING FOR YOU ***" 
    self.waypoints.each {|wp| 
      puts wp.lat
      puts wp.long
      #precmd = "echo 0 > /home/pi/fp_forecast.json"
      #system precmd
      #cmd = "/home/pi/get-forecast.sh " + wp.lat.to_s + " " + wp.long.to_s + " >> /home/pi/fp_forecast.json" 
      cmd = "/home/pi/get-forecast.sh " + wp.lat.to_s + " " + wp.long.to_s 
      system cmd
      #sleep(0.5)
    }    
    #forecasts = JSON.parse(File.read('/home/pi/fp_forecast.json'))
    #forecasts.each {|f|
    #  puts f.forecasts.phrase_12char
    #}

  end

end
