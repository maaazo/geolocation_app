class Geolocation < ApplicationRecord
  validates :ip, presence: true, uniqueness: true
end
