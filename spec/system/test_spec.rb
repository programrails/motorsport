require 'rails_helper'

RSpec.describe 'Main page behavior', type: :system, js: true do
  before do
    driven_by(:selenium)
    create(:product_full)
  end

  it 'Check correct result' do
    visit '/'

    fill_in 'sales[from]', with: '2017-03-01'
    fill_in 'sales[to]', with: '2017-03-01'
    click_button 'Refresh'

    expect(page).to have_text('Product')
    expect(page).to have_text('72540.04')
    expect(page).to have_text('Total')
  end

  it 'Checks both missing params' do
    visit '/'

    click_button 'Refresh'

    within '.alert' do
      expect(page).to have_text('The "to" and/or "from" params are missing.')
    end
  end

  it 'Checks one missing param' do
    visit '/'

    fill_in 'sales[from]', with: '2017-03-01'
    click_button 'Refresh'

    within '.alert' do
      expect(page).to have_text('The "to" and/or "from" params are missing.')
    end
  end

  it 'Checks one wrong-formatted param' do
    visit '/'

    fill_in 'sales[from]', with: '2017/03-01'
    fill_in 'sales[to]', with: '2017-03-01'
    click_button 'Refresh'

    within '.alert' do
      expect(page).to have_text('The params are not the date values.')
    end
  end

  it 'Checks correct params change' do
    visit '/'

    fill_in 'sales[from]', with: '2017-03-01'
    fill_in 'sales[to]', with: '2017-03-01'
    click_button 'Refresh'

    expect(page).to have_text('Product')
    expect(page).to have_text('72540.04')
    expect(page).to have_text('Total')

    fill_in 'sales[to]', with: '2017-03-02'

    click_button 'Refresh'

    expect(page).to have_text('Product')
    expect(page).to have_text('128119.42')
    expect(page).to have_text('Total')
  end
end
