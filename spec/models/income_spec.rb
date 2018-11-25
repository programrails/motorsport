require 'rails_helper'

RSpec.describe Income, type: :model do
  let(:product) { create(:product) }

  let(:good_period) { '2017-03-01' }

  let(:bad_period) { '201703-01' }

  let(:good_value) { '72540.04' }

  let(:bad_value) { 'wrong_value' }

  it { should belong_to(:product) }

  it { should validate_presence_of :period }

  it { should validate_presence_of :value }

  describe '#period' do
    it { should_not allow_value(bad_period).for(:period) }

    it { should allow_value(good_period).for(:period) }
  end

  describe '#value' do
    it { should_not allow_value(bad_value).for(:value) }

    it { should allow_value(good_value).for(:value) }
  end
end
