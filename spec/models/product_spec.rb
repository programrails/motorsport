require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:good_title) { '2017-03-01' }

  it { should validate_presence_of :title }

  describe '#title' do
    it { should allow_value(good_title).for(:title) }
    it { should validate_length_of(:title).is_at_most(128) }
  end

  it { should have_many(:incomes) }
end
