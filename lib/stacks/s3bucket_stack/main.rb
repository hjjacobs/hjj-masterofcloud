module S3BucketStack
  extend ActiveSupport::Concern
  include Rubycfn
  included do
    include Concerns::GlobalVariables
    include Concerns::SharedMethods
    include S3BucketStack::S3Bucket

    description generate_stack_description("S3BucketStack")
  end
end
