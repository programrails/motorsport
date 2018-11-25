FactoryBot.define do
  factory :income do
    product
    period { '1970-01-01' }
    value { '0.0' }

    factory :income1 do
      period { '2017-03-01' }
      value { '72540.04' }
    end

    factory :income2 do
      period { '2017-03-02' }
      value { '55579.38' }
    end
  end
end
