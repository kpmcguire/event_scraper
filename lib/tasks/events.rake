namespace :events do
  task :create_ticketfly_csv do
    system("ruby #{Rails.root}/etl/events_ticketfly_csv.rb")
  end

  task :create_localist_events_csv do
    system("ruby #{Rails.root}/etl/events_localist_csv.rb")

  end

  task :create_localist_venues_csv do
    system("ruby #{Rails.root}/etl/venues_localist_csv.rb")
  end

  task :download_csvs do
    system("ruby #{Rails.root}/etl/get_csv_from_s3.rb")
  end

  task  :import_events do
    system("ruby #{Rails.root}/etl/events_import.rb")
  end

  task :import_venues do
    system("ruby #{Rails.root}/etl/venues_import.rb")
  end

end