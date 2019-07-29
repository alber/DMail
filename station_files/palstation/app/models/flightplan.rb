    #forecasts = JSON.parse(File.read('/home/pi/fp_forecast.json'))
class Flightplan < ApplicationRecord
  has_many :waypoints
  after_validation :fetch_wforecast, on: [ :update ]

  ###
  ###  SETPOINTS FOR FLIGHTPLAN CANCELLATION DUE TO WEATHER
  ###
  
  WEATHER_SP_max_pop = 40  #Percent, Probability of Precipitation
  WEATHER_SP_max_temp= 40  #Celsius
  WEATHER_SP_min_temp= 5   #Celsius
  WEATHER_SP_max_windspd=20#mph
  WEATHER_SP_max_gust= 11  #mph 
  WEATHER_SP_min_visi= 2   #visibility points 
  WEATHER_SP_max_snowrat= 0#inches? acc per 15 min

private
  def boolean_nils(fieldval)
    if (fieldval.nil?)
      return 0
    else
      return fieldval
    end
  end

  def fetch_wforecast
    all_validations_pass = true
    all_severities = 0  # 5 severity levels presumed. Docs unclear.
    self.waypoints.each {|wp| 
      precmd = "echo '' > /home/pi/fp_forecast.json"
      system precmd
      cmd = "/home/pi/get-forecast.sh " + wp.lat.to_s + " " + wp.long.to_s + " >> /home/pi/fp_forecast.json" 
      system cmd
      sleep(0.5)
      forecasts_all = JSON.parse(File.read('/home/pi/fp_forecast.json'))
      forecasts15_next_hour = forecasts_all["forecasts"][0,4]
      forecasts15_next_hour.each {|f15|
      puts forecasts15_next_hour

      # VALIDATE RAIN
      f15["pop"] = boolean_nils(f15["pop"])
      if ( f15["pop"] > WEATHER_SP_max_pop )
        all_validations_pass &&= false
      end

      # VALIDATE TEMPERATURE
      f15["temp"] = boolean_nils(f15["temp"])
      if ( f15["temp"] > WEATHER_SP_max_temp || f15["temp"] < WEATHER_SP_min_temp )
        all_validations_pass &&= false
      end

      # VALIDATE WIND
      f15["wspd"] = boolean_nils(f15["wspd"])
      f15["gust"] = boolean_nils(f15["gust"])
      if ( f15["wspd"] > WEATHER_SP_max_windspd || f15["gust"] > WEATHER_SP_max_gust )
        all_validations_pass &&= false
      end

      # VALIDATE VISIBILITY
      f15["vis"] = boolean_nils(f15["vis"])
      if ( f15["vis"] < WEATHER_SP_min_visi  )
        all_validations_pass &&= false      
      end

      # VALIDATE OTHERs
      f15["snow_rate"] = boolean_nils(f15["snow_rate"])
      if ( f15["snow_rate"] > WEATHER_SP_max_snowrat)
        all_validations_pass &&= false
      end

      # SEVERITY      
      f15["severity"] = boolean_nils(f15["severity"])
      all_severities += f15["severity"]      
  
      }  # end each of the next 4 15min forecasts
    }  # end each waypoint belonging_to this flightplan    
    
    self.weather_score= all_severities.to_f / self.waypoint_count #( all_severities / 20 ) * 100
    self.weather_pass = all_validations_pass
  end  # end fetch_wforecast method  

end
