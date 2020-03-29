require_relative "../../core/applications"

module InfraStack
  module Parent
    extend ActiveSupport::Concern
    included do
      generate_bootstrap_parameters

      resource :vpc_stack,
               type: "AWS::CloudFormation::Stack" do |r|
        r.property(:template_url) { "vpcstack" }
        r.property(:tags) { default_tags }
      end

      resource :bucket_stack,
               type: "AWS::CloudFormation::Stack" do |r|
        r.property(:template_url) { "bucketstack" }
        r.property(:tags) { default_tags }
      end

      resource :acm_stack,
               type: "AWS::CloudFormation::Stack" do |r|
        r.property(:template_url) { "acmstack" }
        r.property(:tags) { default_tags }
      end

      resource :ecs_stack,
               type: "AWS::CloudFormation::Stack" do |r|
        r.property(:template_url) { "ecsstack" }
        r.property(:tags) { default_tags }
      end

      create_applications
    end
  end
end
