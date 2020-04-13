module LambdaStack
  module LambdaFunction
    extend ActiveSupport::Concern
    included do
      # https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-resource-function.html
      transform # This keyword enables CloudFormation transformations. In essence, it allows for the use of Serverless Framework (SAM) in CFN.

      lambda_function_code = file_to_inline("lib/lambdas/post_to_slack.py") # Useful method for storing code as a single String

      # ASSIGNMENT: Implement this as a Serverless Resource


      resource :slackposter,
               type: "AWS::Serverless::EventSource" do |r|
        r.property(:http_api_event) do {
          "Type": "HttpApi",
          "Properties": {
            "Path": "/",
            "Method": "POST"
          }
        }
        end
      end

      # resource :slackposter,
      #          type: "AWS::Serverless::HttpApi" do |r|
      #   r.property(:path) {"/"}
      #   r.property(:method) {"POST"}
      # end

      resource :my_serverless_function,
               type: "AWS::Serverless::Function" do |r|
        r.property(:description) {"Lambda function - master of cloud"}
        r.property(:environment) do {
              "Variables": {
                "SLACK_POSTHOOK_URL": ENV["SLACK_POSTHOOK_URL"],
                "MY_DOMAIN_NAME": ENV["MY_DOMAIN_NAME"]
              }
            }
        end
        r.property(:events) {:slackposter.ref}
        # r.property(:events) do [
        #     :slackposter.ref
        #   ]
        # end
        # r.property(:events) do [
        #       "HttpApiEvent": {
        #         "Type": "HttpApi",
        #         "Properties": {
        #           "Path": "/",
        #           "Method": "POST"
        #         }
        #       }
        #    ]
        # end
        r.property(:handler) {"index.lambda_handler"}
        r.property(:inline_code) {"#{lambda_function_code}"}
        r.property(:timeout) {3}
        r.property(:runtime) {"python3.7"}
        r.property(:tags) { default_tags }
      end
    end
  end
end
