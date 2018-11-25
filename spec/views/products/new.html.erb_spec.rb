require 'rails_helper'

RSpec.describe 'admin/products/new', type: :view do
  before(:each) do
    assign(:product, Product.new(
                       title: 'MyString'
                     ))
  end

  it 'renders new product form' do
    render

    assert_select 'form[action=?][method=?]', admin_products_path, 'post' do
      assert_select 'input[name=?]', 'product[title]'
    end
  end
end
