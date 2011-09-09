require 'geocoder'

namespace :geocode do
  task :users => :environment do
    puts "Key: . - skipped; G - geocoded;"
    $stdout.sync = true

    geocoder = Geocoder.new
    User.all.each do |user|
      unless user.latlong == nil || user.latlong == []
        print "."
        next
      end

      ll = geocoder.geocode!(user.location)
      user.latlong = ll

      user.save!
      print "G"
    end

    print "\n Done\n"
  end
end
