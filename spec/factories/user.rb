FactoryGirl.define do

  factory :user do # FactoryGirl will assume that the parent model of a factory named ":user" is "User".
    email 'alice@example.com'
    # username 'alice'
    password '12345678'
    password_confirmation '12345678'
  end

end
