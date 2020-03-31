module DatabaseStack
  module Database
    extend ActiveSupport::Concern
    included do

      resource :my_database_security_group,
               type: "AWS::RDS::DBSecurityGroup" do |r|
        r.property(:db_security_group_ingress) do
          [
            "CIDRIP": ENV["CIDRIP"]
          ]
        end
        r.property(:group_description) {"my_database sec group"}
        r.property(:tags) { default_tags }
      end

      resource :my_database,
               type: "AWS::RDS::DBInstance" do |r|
        r.property(:db_instance_class) { ENV["DB_INSTANCE_CLASS"] }
        r.property(:engine) {"MySQL"}
        r.property(:master_username) { ENV["DATABASE_MASTERUSER"] }
        r.property(:master_user_password) { ENV["DATABASE_PASSWORD"] }
        r.property(:publicly_accessible) {true}
        r.property(:allocated_storage) { ENV["ALLOCATED_STORAGE"] }
        r.property(:db_security_groups) do
          [
            :my_database_security_group.ref
          ]
        end
        r.property(:db_snapshot_identifier) { ENV["DATABASE_SNAPSHOT"] }
        r.property(:tags) { default_tags }
      end
    end
  end
end
