require_relative 'shared'

connection = Fog::Storage.new({
  provider: 'AWS',
  aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  region: ENV['AWS_REGION']
})

def do_it(s3_file)
  CSV.parse(s3_file.body, headers: true) do |row|
    venues_hash = row.to_hash 
    Venue.where(remote_id: venues_hash['remote_id']).first_or_create(venues_hash)
  end 
end

localist_venues_directory = connection.directories.get(ENV['S3_BUCKET'], prefix: 'venues_csv/')

localist_venues_directory.files.each do |s3_file|
  do_it(s3_file)
end
