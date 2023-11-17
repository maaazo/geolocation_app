# Sample location data
sample_location_data = {
  'type' => 'ipv4',
  'continent_code' => 'NA',
  'continent_name' => 'North America',
  'country_code' => 'US',
  'country_name' => 'United States',
  'region_code' => 'CA',
  'region_name' => 'California',
  'city' => 'Los Angeles',
  'zip' => '90012',
  'latitude' => 34.0655517578125,
  'longitude' => -118.24053955078125,
  'location' => {
    'geoname_id' => 5368361,
    'capital' => 'Washington D.C.',
    'languages' => [
      {
        'code' => 'en',
        'name' => 'English',
        'native' => 'English'
      }
    ],
    'country_flag' => 'https://assets.ipstack.com/flags/us.svg',
    'country_flag_emoji' => '🇺🇸',
    'country_flag_emoji_unicode' => 'U+1F1FA U+1F1F8',
    'calling_code' => '1',
    'is_eu' => false
  }
}

# Create 20 records with different IP addresses
20.times do
  ip_address = Faker::Internet.ip_v4_address

  Geolocation.create(
    ip: ip_address,
    location: sample_location_data.merge('ip' => ip_address)
  )
end
