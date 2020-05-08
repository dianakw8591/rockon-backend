require 'net/http'
require 'open-uri'
require 'json'

def get_data(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  response.body
end

def parse(url)
  JSON.parse(get_data(url))
end

def update_route(hash, converted_type, converted_rating)
  climb = Climb.find_by(mtnproj_id: hash['id'])
  climb.update(name: hash['name'], full_type: hash['type'], key_type: converted_type, rating: hash['rating'], numeric_rating: converted_rating, stars: hash['stars'], pitches: hash['pitches'], lon: hash['longitude'], lat: hash['latitude'], area_array: hash['location'])
end

def convert_type(str)
  type = str.split(', ').first
end

# for Trad, Sport, TR
def convert_rating_yds(str)
  yds_conversion = {
  "5.0" => 1,
  "5.1" => 2,
  "5.2" => 3,
  "5.3" => 4,
  "5.4" => 5,
  "5.5" => 6,
  "5.6" => 7,
  "5.7" => 8,
  "5.8" => 9,
  "5.9" => 10,
  "5.10" => 13,
  "5.10-" => 11,
  "5.10+" => 14,
  "5.10a" => 11,
  "5.10b" => 12,
  "5.10c" => 13,
  "5.10d" => 14,
  "5.11" => 17,
  "5.11-" => 15,
  "5.11+" => 18,
  "5.11a" => 15,
  "5.11b" => 16,
  "5.11c" => 17,
  "5.11d" => 18,
  "5.12" => 21,
  "5.12-" => 19,
  "5.12+" => 22,
  "5.12a" => 19,
  "5.12b" => 20,
  "5.12c" => 21,
  "5.12d" => 22,
  "5.13" => 25,
  "5.13-" => 23,
  "5.13+" => 26,
  "5.13a" => 23,
  "5.13b" => 24,
  "5.13c" => 25,
  "5.13d" => 26,
  "5.14" => 29,
  "5.14-" => 27,
  "5.14+" => 30,
  "5.14a" => 27,
  "5.14b" => 28,
  "5.14c" => 29,
  "5.14d" => 30,
  "5.15" => 33,
  "5.15-" => 31,
  "5.15+" => 34,
  "5.15a" => 31,
  "5.15b" => 32,
  "5.15c" => 33,
  "5.15d" => 34
  }
  yds = str.match(/5\.(?:1[0-5]{1}[abcd+-]{0,1}|[0-9]{1})/).to_s
  yds_conversion[yds]
end

# for Boulder
def convert_rating_v(str)
  v_conversion = {
    "V" => 8,
    "V0" => 10,
    "V1" => 13,
    "V2" => 15,
    "V3" => 17,
    "V4" => 18,
    "V5" => 19,
    "V6" => 21,
    "V7" => 22,
    "V8" => 24,
    "V9" => 26,
    "V10" => 27,
    "V11" => 28,
    "V12" => 29,
    "V13" => 30,
    "V14" => 31,
    "V15" => 32,
    "V16" => 33,
    "V17" => 34,
  }
  v = str.match(/V[0-9]*/).to_s
  v_conversion[v]
end

def get_id_array
  Climb.all.map { |climb| climb.mtnproj_id }
end

def make_strs(array)
  i = 0
  new_array = []
  while i < array.length do
    new_array << array.slice(i, 200).join(',')
    i += 200
  end
  new_array
end

# takes array of concatenated strings from make_strs
def call_mtnproject_api(array)
  base_url = 'https://www.mountainproject.com/data/get-routes?routeIds='
  api_key = Rails.application.credentials.mtn_project_api_key
  array.each do |id_string|
    url = base_url + id_string + '&key=' + api_key
    routes = parse(url)
    routes["routes"].each do |route|
      key_type = convert_type(route['type'])
      if key_type == "Trad" || key_type == "Sport" || key_type == "TR"
        key_rating = convert_rating_yds(route['rating'])
      elsif key_type == "Boulder"
        key_rating = convert_rating_v(route['rating'])
      else 
        key_rating = nil
      end
      update_route(route, key_type, key_rating)
    end
  end
end

call_mtnproject_api(make_strs(get_id_array))

# Returns details for up to 200 routes.
# Required Arguments:
# key - Your private key
# routeIds - A comma-separated list of route IDs, up to 100
# Example:
# https://www.mountainproject.com/data/get-routes?routeIds=105748391,105750454,105749956&key=API_KEY

# run script with rails runner app/jobs/call_mtnproject_api.rb
