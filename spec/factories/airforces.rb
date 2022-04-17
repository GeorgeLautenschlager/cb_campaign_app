FactoryBot.define do
  factory :airforce do
    raf
  end

  trait :raf do
    name { 'RAF' }
    coalition { 'allied' }
  end

  trait :usaaf do
    name { 'USAAF' }
    coalition { 'allied' }
  end

  trait :luftwaffe do
    name { 'Luftwaffe' }
    coalition { 'axis' }
  end

  trait :vvs do
    name { 'VVS' }
    coalition { 'allied' }
  end
end