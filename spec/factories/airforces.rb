FactoryBot.define do
  factory :airforce do
    raf
  end

  trait :raf do
    name { 'RAF' }
    coalition { 'allies' }
  end

  trait :usaaf do
    name { 'USAAF' }
    coalition { 'allies' }
  end

  trait :luftwaffe do
    name { 'Luftwaffe' }
    coalition { 'axis' }
  end

  trait :vvs do
    name { 'VVS' }
    coalition { 'allies' }
  end
end