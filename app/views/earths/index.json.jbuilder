json.array!(@earths) do |earth|
  json.extract! earth, :id, :code_provision, :tip, :region, :district, :city, :street_type, :street_name, :street_name2, :namber_home, :number, :housing, :room_apartment, :total_area, :floor_area, :area_land, :district_number, :kategorіya_repair, :uah_market_value, :usd_market_value, :euro_market_value
  json.url earth_url(earth, format: :json)
end
