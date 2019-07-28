class Pal < ApplicationRecord
  belongs_to :payload
  belongs_to :flightplan
end
