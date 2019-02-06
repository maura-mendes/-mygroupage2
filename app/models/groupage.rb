class Groupage < ApplicationRecord
  belongs_to :user
  belongs_to :container
  # before_save :geocode_endpoints
    validates :departure_date, presence: true

  geocoded_by :origin, :latitude => :latitude, :longitude => :longitude
  geocoded_by :destination, :latitude => :destination_latitude, :longitude => :destination_longitude
  after_validation :geocode_endpoints, if: :will_save_change_to_origin?
  after_validation :geocode_endpoints, if: :will_save_change_to_destination?



	PHONE_PREFIX = @currencies = ["+33", "+44", "+35", "+61", "+1"]
	# validates :phone_prefix, inclusion: {in: PHONE_PREFIX}

	def geocode_endpoints
	    if origin_changed?
	      geocoded = Geocoder.search(origin).first
	      if geocoded
	        self.latitude = geocoded.latitude
	        self.longitude = geocoded.longitude
	      end
	    end
	    if destination_changed?
	      geocoded = Geocoder.search(destination).first
	      if geocoded
	        self.destination_latitude = geocoded.latitude
	        self.destination_longitude = geocoded.longitude
	      end
	    end
	end
end







