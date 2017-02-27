namespace :cities_db do
  require 'csv'

  task :add => [:environment] do
      csv_text = File.read('lib/assets/cities_us.csv')
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
      City.create!(row.to_hash)
    end

  end

end
