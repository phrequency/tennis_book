CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: 'ACCESS ID',
    aws_secret_access_key: 'ACCESS ID',
    region: 'us-west-2'
  }
  config.fog_directory = 'tennis-book'
end