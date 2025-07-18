S3Client = Aws::S3::Client.new(
  access_key_id: ENV['AWS_S3_ID'],
  secret_access_key: ENV['AWS_S3_SECRET'],
  region: 'eu-north-1',
  bucket: ENV['AWS_S3_BUCKET'],
  public: true
) 