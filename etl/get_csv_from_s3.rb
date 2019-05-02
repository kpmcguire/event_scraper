require_relative 'shared'

connection = Fog::Storage.new({
  provider: 'AWS',
  aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  region: ENV['AWS_REGION']
})

directory = connection.directories.get("ithacaeventscalendar")

directory.files.each do |s3_file|
  file = File.extname(s3_file.key)
  if file == ".csv"  
    File.open("#{Rails.root}/etl/#{s3_file.key}", 'wb+') do |local_file|
      local_file.write(s3_file.body)
    end
  end
end

