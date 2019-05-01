require_relative '../config/environment'
require 'aws-sdk-s3'  # v2: require 'aws-sdk'

Aws.config.update({
  region: ENV['AWS_REGION'],
  credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
})

# S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET'])

# puts S3_BUCKET.name

puts ENV['S3_BUCKET']

puts ENV['AWS_ACCESS_KEY_ID']
