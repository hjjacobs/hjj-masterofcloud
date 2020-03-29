module S3BucketStack
  module S3Bucket
    extend ActiveSupport::Concern
    included do
      resource :my_s3_bucket,
               type: "AWS::S3::Bucket" do |r|
        r.property(:BucketName) { "my_s3_bucket" }
        r.property(:tags) { default_tags }
      end
    end
  end
end
