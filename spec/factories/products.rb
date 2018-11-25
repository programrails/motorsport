FactoryBot.define do
  factory :product do
    title { 'Product' }

    factory :product_full do
      after(:create) do |product_full, _evaluator|
        create(:income, product: product_full, period: '2017-03-01', value: '72540.04')
        create(:income, product: product_full, period: '2017-03-02', value: '55579.38')
      end
    end
  end
end
