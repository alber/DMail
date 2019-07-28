class Message < ApplicationRecord

  before_create do
    if self.id.nil?
      uid = DateTime.now.strftime('%Q').to_i
      self.id = uid
    end
  end


end
