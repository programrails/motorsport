require 'rails_helper'

RSpec.describe 'admin/products/index', type: :view do
  before(:each) do
    assign(:products, [
             Product.create!(
               title: 'Title'
             ),
      Product.create!(
        title: 'Title'
      )
           ])
  end

  it 'renders a list of products' do
    render
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
  end
end
