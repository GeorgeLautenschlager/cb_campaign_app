FactoryBot.define do
  factory :airforce do
    raf
  end

  trait :raf do
    name { 'RAF' }
    coalition { 'allies' }
  end
end