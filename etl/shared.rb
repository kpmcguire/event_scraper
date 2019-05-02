require_relative '../config/environment'
require 'httparty'
require 'csv'
# require 'aws-sdk-s3'  # v2: require 'aws-sdk'
require 'fog-aws'
Dotenv.load("#{Rails.root}/.env")

class Send_to_s3
  def initialize(path, filename)
    @path = path
    @filename = filename

    @connection = Fog::Storage.new({
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_REGION']
    })

    @directory = @connection.directories.get("ithacaeventscalendar")
    send_it

  end

  def send_it
    local_path = "#{Rails.root}/etl/#{@path}/#{@filename}"
    s3_path = "#{@path}/#{@filename}"

    FileUtils.move @filename, "#{Rails.root}/etl/#{@path}/#{@filename}"

    file = @directory.files.new({
      :key    => s3_path,
      :body   => File.open("#{local_path}")
    })
    file.save

  end
end
