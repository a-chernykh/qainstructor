FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :code do |n|
    "code-#{n}"
  end

  factory :user do
    first_name 'John'
    last_name 'Doe'
    email
    password 'MyC00lPassword'
  end

  factory :course do
    name 'Test course'
    price_cents 3900
    code
    level 'intermediate'
    completion_time_hours 5
    description 'Bla bla bla'
  end

  factory :chapter do
    course
    section
    code
    name 'Test chapter'
    description 'Bla bla bla'
    position 0
  end

  factory :cheatsheet do
    course
    code
  end

  factory :coupon do
    course
    code
    discount_percent 50
  end

  factory :job do
    user
    language 'cucumber'
    status 'created'
    files [
      { 'name' => 'scenario.feature', 'contents' => '...' }
    ]
  end

  factory :job_asset do
    job
    file File.open(Rails.root.join('spec/fixtures/output.html'))
  end

  factory :exercise do
    chapter
    content '...'
  end

  factory :offline_registration do
    name 'John Doe'
    phone '+1 (111) 111-11-11'
    email 'john.doe@example.com'
  end

  factory :redemption do
    user
    coupon
    redeemed_at { Time.now }
  end

  factory :section do
    course
    code
    name 'Test position'
    position 0
  end

  factory :user_completion do
    user
    association :completable, factory: :chapter
    started_at { Time.now }

    trait :completed do
      completed_at { Time.now }
    end
  end

  factory :user_course do
    user
    course
  end
end
