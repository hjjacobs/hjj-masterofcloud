module BucketStack
  module Bucket
    extend ActiveSupport::Concern
    included do
      resource :my_s3_bucket,
               type: "AWS::S3::Bucket" do |r|
        r.property(:tags) { default_tags }
      end
    end
  end
end
