module OneStack
  module Bucket
    extend ActiveSupport::Concern
    included do
      # https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket.html
      # TODO: Also create a 404 error page
      resource :my_s3_bucket_resource,
               deletion_policy: "Retain",
               type: "AWS::S3::Bucket" do |r|
        r.property(:access_control) { "PublicRead" }
        r.property(:website_configuration) do
          {
            "IndexDocument": "index.html",
            "ErrorDocument": "404.html"
          }
        end
      end

      resource :bucket_policy,
               depends_on: "MyS3BucketResource",
               type: "AWS::S3::BucketPolicy" do |r|
        r.property(:bucket) { :my_s3_bucket_resource.ref }
        r.property(:policy_document) do
          {
            "Id": "My#{environment}BucketPolicy",
            "Version": "2012-10-17",
            "Statement": [
              {
                "Sid": "PublicReadForGetBucketObjects",
                "Effect": "Allow",
                "Principal": "*",
                "Action": "s3:GetObject",
                "Resource": [
                  "arn:aws:s3:::",
                  :my_s3_bucket_resource.ref,
                  "/*"
                ].fnjoin
              }
            ]
          }
        end
      end

      output :my_s3_bucket_name,
             value: :my_s3_bucket_resource.ref
      output :my_s3_bucket_domain_name,
             value: :my_s3_bucket_resource.ref(:domain_name)
      output :my_s3_bucket_website_url,
             value: :my_s3_bucket_resource.ref("WebsiteURL")
    end
  end
end
