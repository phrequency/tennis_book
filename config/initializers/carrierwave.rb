CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: 'AKIAIMGYJXQ76NRH7YTQ',
    aws_secret_access_key: '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',
    region: 'us-west-2'
  }
  config.fog_directory = 'tennis-book'
end