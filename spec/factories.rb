FactoryGirl.define do
  factory :user do
    name     "William"
    email    "william@mail.labs.epiuse.com"
    password "foobar"
    password_confirmation "foobar"
  end
end