class Apartment < ActiveRecord::Base

 #validates :uah_market_value, presence: true
  has_many :capartments

  def self.to_csv(options = {})
    (CSV.generate(options) do |csv|
      # column headers for table - language
      column_header = [ "Системный номер", "Kод oбеспечення ", "Новый код ", "Номер счета ", "Альтернативный номер счета ",
                        "Тип обеспечения ", "Область ", "Район ", "Тип населенного пунтка ", "Город ", "Тип улицы ",
                        "Название улицы ", "Номер дома ", "Номер дома ", "Номер квартиры ", "Площадь ",
                        "Жилая площадь, кв.м ", "Кол. комнат ", "Этаж ", "Этажность ", "Серия дома ", "№ района ",
                        "Рыночная стоимость, грн ", "Рыночная стоимость, дол.США ", "Рыночная стоимость, евро "]
      csv << column_names
      csv << column_header
      all.each do |product|
        conv_prod = product.attributes.values_at(*column_names).map(&:to_s)
        csv << conv_prod
      end
    end).encode('Windows-1251')
  end

  def self.import(file)
    @array_error = Array.new([])
    allowed_attributes = [ "code_provision","new_code","account_number","alt_account_number","tip","region",
    "district","type_settlement","city","street_type","street_name","number_house","number_house2","room_apartment",
        "area","floor_area","number_rooms","storey","floors","series_home","district_number",
        "uah_market_value","usd_market_value","euro_market_value"]
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    header = [ "code_provision","new_code","account_number","alt_account_number","tip","region",
               "district","type_settlement","city","street_type", "street_name", "number_house", "number_house2","room_apartment",
               "area","floor_area","number_rooms","storey","floors","series_home","district_number",
               "uah_market_value","usd_market_value","euro_market_value"]
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["code_provision"]) || new
      #product.attributes = row.to_hash
      product.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
      #product.save!
      if product.valid?
        product.save!
      else
        @array_error.push(row["code_provision"])
      end
    end
  end


  def self.check_import_errors
    if @array_error.blank?
      true
    else
      false
      @array_error
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
      when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
      when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end


end
