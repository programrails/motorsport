require 'rails_helper'

RSpec.describe 'admin/products/show', type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
                                  title: 'Title'
                                ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
  end
end
