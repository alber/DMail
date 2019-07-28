class Message < ApplicationRecord
  
  before_create do
    if self.id.nil?
      uid = DateTime.now.strftime('%Q').to_i
      self.id = uid
    end
  end
  
  before_save do
    self_station = Station.find_by is_me: true    
    if self.final_destination_id == self_station.id
      self.is_received = true
    end
  end

end
