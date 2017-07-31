# weatherforecast
require_relative 'environment'
require 'HTTParty'
require 'date'
require 'pry'
require 'pry-byebug'
require_relative 'sample_response'

class WeatherForecast
  API_KEY = WEATHER_KEY
  attr_reader :location, :num_days, :response_hash, :raw_response

# comment
  def initialize(location = 'france', num_days = 5)
    @location = location
    @num_days = num_days
    @raw_response = String.new
    send_request
  end
  # high temperatures organized by date
  def hi_temps
    print_temps(@response_hash, "temp_max", "High of ")
  end

  # low temperatures organized by date
  def lo_temps
    print_temps(@response_hash, "temp_min", "Low of ")
  end

  # today's forecast
  def today
    print_forecast(@response_hash, Date.today)
  end
 # tomorrow's forecast
  def tomorrow
    tomorrow = Date.today + 1
    print_forecast(@response_hash, tomorrow)
  end

  # three more responses
  def rain_forecast
    if is_raining?(Date.today)
      puts "It's gonna rain"
    else
      puts "Leave the umbrella at home."
    end
  end

  # five_day
  def five_day
  # creates a 5 day forecast
    day_1 = Date.today
    4.times do
      print_forecast(@response_hash, Date.today)
      puts
    end
  end


  private
  def send_request
    # @raw_response = HTTParty.get('http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=' + API_KEY)
    # jewel = HTTParty.get('http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=6b37a31859bac22974dd421ee55c1bd3')
    # mockup of json response from API
    parse_response
  end

  def parse_response
    # @response_hash = JSON.parse(@raw_response.body)
    ###
    @response_hash = {"cod"=>"200", "message"=>0.0066, "cnt"=>40, "list"=>[{"dt"=>1501513200, "main"=>{"temp"=>296.9, "temp_min"=>295.238, "temp_max"=>296.9, "pressure"=>1006.48, "sea_level"=>1025.78, "grnd_level"=>1006.48, "humidity"=>70, "temp_kf"=>1.66}, "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"01d"}], "clouds"=>{"all"=>0}, "wind"=>{"speed"=>5.36, "deg"=>321.503}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-07-31 15:00:00"}, {"dt"=>1501524000, "main"=>{"temp"=>293.61, "temp_min"=>292.366, "temp_max"=>293.61, "pressure"=>1008.09, "sea_level"=>1027.44, "grnd_level"=>1008.09, "humidity"=>70, "temp_kf"=>1.25}, "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"01n"}], "clouds"=>{"all"=>0}, "wind"=>{"speed"=>4.01, "deg"=>317.003}, "rain"=>{}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2017-07-31 18:00:00"}, {"dt"=>1501534800, "main"=>{"temp"=>291.31, "temp_min"=>290.483, "temp_max"=>291.31, "pressure"=>1008.74, "sea_level"=>1028.24, "grnd_level"=>1008.74, "humidity"=>85, "temp_kf"=>0.83}, "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"01n"}], "clouds"=>{"all"=>0}, "wind"=>{"speed"=>2.52, "deg"=>295.501}, "rain"=>{}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2017-07-31 21:00:00"}, {"dt"=>1501545600, "main"=>{"temp"=>289.58, "temp_min"=>289.161, "temp_max"=>289.58, "pressure"=>1009.47, "sea_level"=>1029.03, "grnd_level"=>1009.47, "humidity"=>87, "temp_kf"=>0.42}, "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"02n"}], "clouds"=>{"all"=>8}, "wind"=>{"speed"=>2.41, "deg"=>253.5}, "rain"=>{}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2017-08-01 00:00:00"}, {"dt"=>1501556400, "main"=>{"temp"=>290.266, "temp_min"=>290.266, "temp_max"=>290.266, "pressure"=>1009.71, "sea_level"=>1029.21, "grnd_level"=>1009.71, "humidity"=>87, "temp_kf"=>0}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10d"}], "clouds"=>{"all"=>48}, "wind"=>{"speed"=>1.36, "deg"=>211.502}, "rain"=>{"3h"=>0.1975}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-01 03:00:00"}, {"dt"=>1501567200, "main"=>{"temp"=>296.175, "temp_min"=>296.175, "temp_max"=>296.175, "pressure"=>1010.02, "sea_level"=>1029.4, "grnd_level"=>1010.02, "humidity"=>85, "temp_kf"=>0}, "weather"=>[{"id"=>801, "main"=>"Clouds", "description"=>"few clouds", "icon"=>"02d"}], "clouds"=>{"all"=>24}, "wind"=>{"speed"=>3.05, "deg"=>257.508}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-01 06:00:00"}, {"dt"=>1501578000, "main"=>{"temp"=>297.07, "temp_min"=>297.07, "temp_max"=>297.07, "pressure"=>1010.83, "sea_level"=>1030.11, "grnd_level"=>1010.83, "humidity"=>82, "temp_kf"=>0}, "weather"=>[{"id"=>802, "main"=>"Clouds", "description"=>"scattered clouds", "icon"=>"03d"}], "clouds"=>{"all"=>36}, "wind"=>{"speed"=>4, "deg"=>317.503}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-01 09:00:00"}, {"dt"=>1501588800, "main"=>{"temp"=>297.56, "temp_min"=>297.56, "temp_max"=>297.56, "pressure"=>1011.77, "sea_level"=>1030.98, "grnd_level"=>1011.77, "humidity"=>75, "temp_kf"=>0}, "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"02d"}], "clouds"=>{"all"=>8}, "wind"=>{"speed"=>5.21, "deg"=>310}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-01 12:00:00"}, {"dt"=>1501599600, "main"=>{"temp"=>296.073, "temp_min"=>296.073, "temp_max"=>296.073, "pressure"=>1012.71, "sea_level"=>1032.05, "grnd_level"=>1012.71, "humidity"=>69, "temp_kf"=>0}, "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"01d"}], "clouds"=>{"all"=>0}, "wind"=>{"speed"=>5.12, "deg"=>307.005}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-01 15:00:00"}, {"dt"=>1501610400, "main"=>{"temp"=>292.949, "temp_min"=>292.949, "temp_max"=>292.949, "pressure"=>1013.93, "sea_level"=>1033.39, "grnd_level"=>1013.93, "humidity"=>67, "temp_kf"=>0}, "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"01n"}], "clouds"=>{"all"=>0}, "wind"=>{"speed"=>4.01, "deg"=>309.004}, "rain"=>{}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2017-08-01 18:00:00"}, {"dt"=>1501621200, "main"=>{"temp"=>290.419, "temp_min"=>290.419, "temp_max"=>290.419, "pressure"=>1014.76, "sea_level"=>1034.37, "grnd_level"=>1014.76, "humidity"=>73, "temp_kf"=>0}, "weather"=>[{"id"=>801, "main"=>"Clouds", "description"=>"few clouds", "icon"=>"02n"}], "clouds"=>{"all"=>12}, "wind"=>{"speed"=>3.11, "deg"=>308.001}, "rain"=>{}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2017-08-01 21:00:00"}, {"dt"=>1501632000, "main"=>{"temp"=>288.71, "temp_min"=>288.71, "temp_max"=>288.71, "pressure"=>1015.73, "sea_level"=>1035.42, "grnd_level"=>1015.73, "humidity"=>81, "temp_kf"=>0}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10n"}], "clouds"=>{"all"=>0}, "wind"=>{"speed"=>2.77, "deg"=>307.501}, "rain"=>{"3h"=>0.0049999999999999}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2017-08-02 00:00:00"}, {"dt"=>1501642800, "main"=>{"temp"=>288.431, "temp_min"=>288.431, "temp_max"=>288.431, "pressure"=>1016.17, "sea_level"=>1035.85, "grnd_level"=>1016.17, "humidity"=>88, "temp_kf"=>0}, "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"01d"}], "clouds"=>{"all"=>0}, "wind"=>{"speed"=>1.16, "deg"=>273.5}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-02 03:00:00"}, {"dt"=>1501653600, "main"=>{"temp"=>292.811, "temp_min"=>292.811, "temp_max"=>292.811, "pressure"=>1016.55, "sea_level"=>1036.05, "grnd_level"=>1016.55, "humidity"=>81, "temp_kf"=>0}, "weather"=>[{"id"=>803, "main"=>"Clouds", "description"=>"broken clouds", "icon"=>"04d"}], "clouds"=>{"all"=>56}, "wind"=>{"speed"=>1.92, "deg"=>268.5}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-02 06:00:00"}, {"dt"=>1501664400, "main"=>{"temp"=>294.696, "temp_min"=>294.696, "temp_max"=>294.696, "pressure"=>1015.86, "sea_level"=>1035.17, "grnd_level"=>1015.86, "humidity"=>77, "temp_kf"=>0}, "weather"=>[{"id"=>803, "main"=>"Clouds", "description"=>"broken clouds", "icon"=>"04d"}], "clouds"=>{"all"=>64}, "wind"=>{"speed"=>3.12, "deg"=>251.505}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-02 09:00:00"}, {"dt"=>1501675200, "main"=>{"temp"=>295.256, "temp_min"=>295.256, "temp_max"=>295.256, "pressure"=>1013.89, "sea_level"=>1033.27, "grnd_level"=>1013.89, "humidity"=>70, "temp_kf"=>0}, "weather"=>[{"id"=>803, "main"=>"Clouds", "description"=>"broken clouds", "icon"=>"04d"}], "clouds"=>{"all"=>64}, "wind"=>{"speed"=>3.77, "deg"=>231.501}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-02 12:00:00"}, {"dt"=>1501686000, "main"=>{"temp"=>296.174, "temp_min"=>296.174, "temp_max"=>296.174, "pressure"=>1010.98, "sea_level"=>1030.3, "grnd_level"=>1010.98, "humidity"=>70, "temp_kf"=>0}, "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"01d"}], "clouds"=>{"all"=>0}, "wind"=>{"speed"=>4.62, "deg"=>209.501}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-02 15:00:00"}, {"dt"=>1501696800, "main"=>{"temp"=>295.908, "temp_min"=>295.908, "temp_max"=>295.908, "pressure"=>1008, "sea_level"=>1027.35, "grnd_level"=>1008, "humidity"=>69, "temp_kf"=>0}, "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"02n"}], "clouds"=>{"all"=>8}, "wind"=>{"speed"=>6.16, "deg"=>214.501}, "rain"=>{}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2017-08-02 18:00:00"}, {"dt"=>1501707600, "main"=>{"temp"=>296.179, "temp_min"=>296.179, "temp_max"=>296.179, "pressure"=>1006.09, "sea_level"=>1025.46, "grnd_level"=>1006.09, "humidity"=>68, "temp_kf"=>0}, "weather"=>[{"id"=>801, "main"=>"Clouds", "description"=>"few clouds", "icon"=>"02n"}], "clouds"=>{"all"=>20}, "wind"=>{"speed"=>7.26, "deg"=>230.002}, "rain"=>{}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2017-08-02 21:00:00"}, {"dt"=>1501718400, "main"=>{"temp"=>296.271, "temp_min"=>296.271, "temp_max"=>296.271, "pressure"=>1005.05, "sea_level"=>1024.39, "grnd_level"=>1005.05, "humidity"=>73, "temp_kf"=>0}, "weather"=>[{"id"=>803, "main"=>"Clouds", "description"=>"broken clouds", "icon"=>"04n"}], "clouds"=>{"all"=>76}, "wind"=>{"speed"=>6.31, "deg"=>250.004}, "rain"=>{}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2017-08-03 00:00:00"}, {"dt"=>1501729200, "main"=>{"temp"=>295.107, "temp_min"=>295.107, "temp_max"=>295.107, "pressure"=>1004.68, "sea_level"=>1024.07, "grnd_level"=>1004.68, "humidity"=>80, "temp_kf"=>0}, "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"01d"}], "clouds"=>{"all"=>0}, "wind"=>{"speed"=>4.96, "deg"=>275.503}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-03 03:00:00"}, {"dt"=>1501740000, "main"=>{"temp"=>293.331, "temp_min"=>293.331, "temp_max"=>293.331, "pressure"=>1005.26, "sea_level"=>1024.56, "grnd_level"=>1005.26, "humidity"=>79, "temp_kf"=>0}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10d"}], "clouds"=>{"all"=>88}, "wind"=>{"speed"=>5.91, "deg"=>289.502}, "rain"=>{"3h"=>0.41}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-03 06:00:00"}, {"dt"=>1501750800, "main"=>{"temp"=>292.577, "temp_min"=>292.577, "temp_max"=>292.577, "pressure"=>1005.45, "sea_level"=>1024.7, "grnd_level"=>1005.45, "humidity"=>82, "temp_kf"=>0}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10d"}], "clouds"=>{"all"=>0}, "wind"=>{"speed"=>4.46, "deg"=>276.502}, "rain"=>{"3h"=>0.9}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-03 09:00:00"}, {"dt"=>1501761600, "main"=>{"temp"=>294.971, "temp_min"=>294.971, "temp_max"=>294.971, "pressure"=>1005.25, "sea_level"=>1024.57, "grnd_level"=>1005.25, "humidity"=>70, "temp_kf"=>0}, "weather"=>[{"id"=>801, "main"=>"Clouds", "description"=>"few clouds", "icon"=>"02d"}], "clouds"=>{"all"=>24}, "wind"=>{"speed"=>5.66, "deg"=>287}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-03 12:00:00"}, {"dt"=>1501772400, "main"=>{"temp"=>293.276, "temp_min"=>293.276, "temp_max"=>293.276, "pressure"=>1005.36, "sea_level"=>1024.6, "grnd_level"=>1005.36, "humidity"=>67, "temp_kf"=>0}, "weather"=>[{"id"=>802, "main"=>"Clouds", "description"=>"scattered clouds", "icon"=>"03d"}], "clouds"=>{"all"=>36}, "wind"=>{"speed"=>5.32, "deg"=>295.505}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-03 15:00:00"}, {"dt"=>1501783200, "main"=>{"temp"=>290.758, "temp_min"=>290.758, "temp_max"=>290.758, "pressure"=>1005.7, "sea_level"=>1025.06, "grnd_level"=>1005.7, "humidity"=>70, "temp_kf"=>0}, "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"01n"}], "clouds"=>{"all"=>0}, "wind"=>{"speed"=>3.17, "deg"=>290.5}, "rain"=>{}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2017-08-03 18:00:00"}, {"dt"=>1501794000, "main"=>{"temp"=>287.835, "temp_min"=>287.835, "temp_max"=>287.835, "pressure"=>1005.17, "sea_level"=>1024.69, "grnd_level"=>1005.17, "humidity"=>86, "temp_kf"=>0}, "weather"=>[{"id"=>801, "main"=>"Clouds", "description"=>"few clouds", "icon"=>"02n"}], "clouds"=>{"all"=>24}, "wind"=>{"speed"=>1.37, "deg"=>242.504}, "rain"=>{}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2017-08-03 21:00:00"}, {"dt"=>1501804800, "main"=>{"temp"=>288.428, "temp_min"=>288.428, "temp_max"=>288.428, "pressure"=>1004.87, "sea_level"=>1024.38, "grnd_level"=>1004.87, "humidity"=>85, "temp_kf"=>0}, "weather"=>[{"id"=>803, "main"=>"Clouds", "description"=>"broken clouds", "icon"=>"04n"}], "clouds"=>{"all"=>80}, "wind"=>{"speed"=>1.97, "deg"=>242.002}, "rain"=>{}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2017-08-04 00:00:00"}, {"dt"=>1501815600, "main"=>{"temp"=>288.409, "temp_min"=>288.409, "temp_max"=>288.409, "pressure"=>1003.9, "sea_level"=>1023.28, "grnd_level"=>1003.9, "humidity"=>88, "temp_kf"=>0}, "weather"=>[{"id"=>804, "main"=>"Clouds", "description"=>"overcast clouds", "icon"=>"04d"}], "clouds"=>{"all"=>92}, "wind"=>{"speed"=>1.51, "deg"=>183.501}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-04 03:00:00"}, {"dt"=>1501826400, "main"=>{"temp"=>291.49, "temp_min"=>291.49, "temp_max"=>291.49, "pressure"=>1002.38, "sea_level"=>1021.67, "grnd_level"=>1002.38, "humidity"=>83, "temp_kf"=>0}, "weather"=>[{"id"=>804, "main"=>"Clouds", "description"=>"overcast clouds", "icon"=>"04d"}], "clouds"=>{"all"=>100}, "wind"=>{"speed"=>3.01, "deg"=>191.505}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-04 06:00:00"}, {"dt"=>1501837200, "main"=>{"temp"=>293.319, "temp_min"=>293.319, "temp_max"=>293.319, "pressure"=>999.89, "sea_level"=>1018.97, "grnd_level"=>999.89, "humidity"=>74, "temp_kf"=>0}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10d"}], "clouds"=>{"all"=>92}, "wind"=>{"speed"=>4.21, "deg"=>199}, "rain"=>{"3h"=>0.0099999999999998}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-04 09:00:00"}, {"dt"=>1501848000, "main"=>{"temp"=>291.495, "temp_min"=>291.495, "temp_max"=>291.495, "pressure"=>996.93, "sea_level"=>1016.07, "grnd_level"=>996.93, "humidity"=>86, "temp_kf"=>0}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10d"}], "clouds"=>{"all"=>100}, "wind"=>{"speed"=>5.25, "deg"=>197.002}, "rain"=>{"3h"=>0.8}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-04 12:00:00"}, {"dt"=>1501858800, "main"=>{"temp"=>292.586, "temp_min"=>292.586, "temp_max"=>292.586, "pressure"=>993.72, "sea_level"=>1012.84, "grnd_level"=>993.72, "humidity"=>91, "temp_kf"=>0}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10d"}], "clouds"=>{"all"=>92}, "wind"=>{"speed"=>6.46, "deg"=>233.504}, "rain"=>{"3h"=>0.82}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-04 15:00:00"}, {"dt"=>1501869600, "main"=>{"temp"=>292.134, "temp_min"=>292.134, "temp_max"=>292.134, "pressure"=>994.17, "sea_level"=>1013.31, "grnd_level"=>994.17, "humidity"=>84, "temp_kf"=>0}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10n"}], "clouds"=>{"all"=>76}, "wind"=>{"speed"=>7.42, "deg"=>262.503}, "rain"=>{"3h"=>0.02}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2017-08-04 18:00:00"}, {"dt"=>1501880400, "main"=>{"temp"=>291.223, "temp_min"=>291.223, "temp_max"=>291.223, "pressure"=>994.82, "sea_level"=>1014.04, "grnd_level"=>994.82, "humidity"=>80, "temp_kf"=>0}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10n"}], "clouds"=>{"all"=>76}, "wind"=>{"speed"=>7.41, "deg"=>272.503}, "rain"=>{"3h"=>0.029999999999999}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2017-08-04 21:00:00"}, {"dt"=>1501891200, "main"=>{"temp"=>290.453, "temp_min"=>290.453, "temp_max"=>290.453, "pressure"=>996.03, "sea_level"=>1015.42, "grnd_level"=>996.03, "humidity"=>79, "temp_kf"=>0}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10n"}], "clouds"=>{"all"=>80}, "wind"=>{"speed"=>7.51, "deg"=>281.5}, "rain"=>{"3h"=>0.010000000000001}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2017-08-05 00:00:00"}, {"dt"=>1501902000, "main"=>{"temp"=>290.147, "temp_min"=>290.147, "temp_max"=>290.147, "pressure"=>997.49, "sea_level"=>1016.82, "grnd_level"=>997.49, "humidity"=>80, "temp_kf"=>0}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10d"}], "clouds"=>{"all"=>88}, "wind"=>{"speed"=>6.81, "deg"=>285.501}, "rain"=>{"3h"=>0.02}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-05 03:00:00"}, {"dt"=>1501912800, "main"=>{"temp"=>290.843, "temp_min"=>290.843, "temp_max"=>290.843, "pressure"=>999.12, "sea_level"=>1018.44, "grnd_level"=>999.12, "humidity"=>78, "temp_kf"=>0}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10d"}], "clouds"=>{"all"=>80}, "wind"=>{"speed"=>6.31, "deg"=>284.006}, "rain"=>{"3h"=>0.03}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-05 06:00:00"}, {"dt"=>1501923600, "main"=>{"temp"=>292.344, "temp_min"=>292.344, "temp_max"=>292.344, "pressure"=>1000.71, "sea_level"=>1019.91, "grnd_level"=>1000.71, "humidity"=>75, "temp_kf"=>0}, "weather"=>[{"id"=>802, "main"=>"Clouds", "description"=>"scattered clouds", "icon"=>"03d"}], "clouds"=>{"all"=>32}, "wind"=>{"speed"=>6.37, "deg"=>276.501}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-05 09:00:00"}, {"dt"=>1501934400, "main"=>{"temp"=>294.408, "temp_min"=>294.408, "temp_max"=>294.408, "pressure"=>1001.68, "sea_level"=>1020.89, "grnd_level"=>1001.68, "humidity"=>70, "temp_kf"=>0}, "weather"=>[{"id"=>801, "main"=>"Clouds", "description"=>"few clouds", "icon"=>"02d"}], "clouds"=>{"all"=>12}, "wind"=>{"speed"=>6.66, "deg"=>279.5}, "rain"=>{}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2017-08-05 12:00:00"}], "city"=>{"id"=>524901, "name"=>"Moscow", "coord"=>{"lat"=>55.7522, "lon"=>37.6156}, "country"=>"RU"}}
    ###
  end

  # print_temps
  def print_temps(hash, temp_type, msg)
    city = hash["city"]["name"]
    daily_forecasts = hash["list"]
    puts "Weather for #{city}:"
    daily_forecasts.each do |day|
      puts pretty_date(convert_date(day.["dt_txt"]))
      temperature = get_temp(day, temp_type)
      puts msg + temperature.to_s
    end
  end

  # print_forecast
  def print_forecast(hash, date)
    # prints a forecast for a particular date
    # unix_date = date.to_time.to_i
    # daily_forecasts = hash["list"]

    # forecast_hash is all of the data associated with a given date
    forecast_hash = get_forecast(hash, date)
    max = get_temp(forecast_hash, "temp_max")
    min = get_temp(forecast_hash, "temp_min")

    precip_hash = forecast_hash["weather"][0]
    description = precip_hash["description"].capitalize

    # These values fall under the "main" key
    main_hash = forecast_hash["main"]
    pressure = main_hash["pressure"]
    humidity = main_hash["humidity"]

    # Rain has it's own nexted hash
    rain_hash = forecast_hash["rain"]
    if is_raining?
      rain = 0
    else
      rain = rain_hash["3h"]
    end
    puts "Forecast for #{pretty_date(date)}:\n#{description}\nPressure: #{pressure}\nHumidity: #{humidity}#%\nHigh of #{max}, low of #{min}\nChance of rain: #{(rain * 100)}%"
  end

  def is_raining?(date)
    forecast = get_forecast(@response_hash, date)
    if forecast_hash["rain"].empty?
      true
    else
      false
    end
  end

  # get_forecast
  def get_forecast(hash, date)
    # checks value of a date against dates in the hash
    # returns the hash of that date if a match
    hash["list"].each do |day|
      day_in_hash = day["dt_txt"]
      converted_date = convert_date(day_in_hash)
      if date == converted_date
        return day
        break
      end
    end
  end

  # get_temp
  def get_temp(day, temp_type)
    # gets the temperatures of a day, requires a temp_type (hi/lo)
    temps = day["main"]
    req_temp = temps[temp_type]
    convert_temp(req_temp)
  end

  # converts temperature to celcius
  def convert_temp(temp)
    output = (temp + -273.15).to_i
    return output.to_s
  end

  # converts unix date
  def convert_date(date_as_string)
    Date.parse(date_as_string)
  end

  # gets the date of the forecast
  # def get_date(unix_date)
  #   date = convert_date(unix_date)
  #   return date.strftime('%a %b %d %Y')
  # end

  def pretty_date(date)
    date.strftime('%a %b %d %Y')
  end

end
