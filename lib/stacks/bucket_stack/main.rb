module BucketStack
  extend ActiveSupport::Concern
  include Rubycfn
  included do
    include Concerns::GlobalVariables
    include Concerns::SharedMethods
    include BucketStack::Bucket

    description generate_stack_description("BucketStack")
  end
end
