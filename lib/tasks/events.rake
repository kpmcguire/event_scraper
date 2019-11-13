namespace :events do
  task :import do
    if Time.now.monday? || Time.now.wednesday? || Time.now.friday?
      system("ruby #{Rails.root}/etl/events_import_eventbrite.rb")
    end

    if Time.now.tuesday? || Time.now.thursday?
      system("ruby #{Rails.root}/etl/events_import_localist.rb")
    end

    if Time.now.saturday?
      system("ruby #{Rails.root}/etl/venues_import_localist.rb")
    end    

    if Time.now.sunday?
      system("ruby #{Rails.root}/etl/remove_old_data.rb")
    end
  end
end