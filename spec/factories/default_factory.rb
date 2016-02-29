FactoryGirl.define do

  sequence :unique_name do |n|
    "some cool name#{n}"
  end

  sequence :unique_email do |n|
    "foo#{n}@bar.com"
  end

  sequence :unique_username do |n|
    "unique username#{n}"
  end

  sequence :password do |n|
    "password#{n}"
  end

  factory :user do
    first_name  { generate(:unique_name) }
    last_name  { generate(:unique_name) }
    email { generate(:unique_email) }
    username { generate(:unique_username) }
    password { generate(:password) }
  end

end