class Pal < ApplicationRecord
  belongs_to :payload, optional: true
  belongs_to :flightplan, optional: true
end
