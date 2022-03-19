FactoryBot.define do
  factory :pilot do
    user

    trait :raf do
      type { "RafPilot" }
    end
  end
end