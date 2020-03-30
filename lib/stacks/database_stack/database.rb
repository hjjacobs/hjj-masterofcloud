module DatabaseStack
  module Database
    extend ActiveSupport::Concern
    included do
      resource :my_database,
               type: "AWS::RDS::DBInstance" do |r|
        r.property(:db_instance_class) {"db.t2.micro"}
        r.property(:engine) {"MySQL"}
        r.property(:master_username) {"movies"}
        r.property(:master_user_password) { ENV["DATABASE_PASSWORD"] }
        r.property(:publicly_accessible) {true}
        r.property(:allocated_storage) {"5"}
        r.property(:tags) { default_tags }
      end
    end
  end
end
