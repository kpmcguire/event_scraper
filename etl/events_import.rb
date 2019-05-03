require_relative 'shared'

connection = Fog::Storage.new({
  provider: 'AWS',
  aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  region: ENV['AWS_REGION']
})

def do_it(s3_file)
  CSV.parse(s3_file.body, headers: true) do |row|
    events_hash = row.to_hash 
    Event.where(name: events_hash['name'], start_time: events_hash['start_time']).first_or_create(events_hash)
  end 
end

ticketfly_directory = connection.directories.get(ENV['S3_BUCKET'], prefix: 'events_ticketfly_csv/')

localist_directory = connection.directories.get(ENV['S3_BUCKET'], prefix: 'events_localist_csv/')

ticketfly_directory.files.each do |s3_file|
  do_it(s3_file)
end

localist_directory.files.each do |s3_file|
  do_it(s3_file)
end



