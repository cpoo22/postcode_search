# frozen_string_literal: true

feature 'Search' do
  scenario 'Has a search page' do
    visit '/search'
    expect(page).to have_content 'Search'
  end

  scenario 'Searching for a not allowed postcode' do
    visit '/search'
    fill_in 'postcode', with: 'BN1 1AL'
    click_button 'Look up Postcode'
    expect(page).to have_content 'Boo hiss boo'
  end

  scenario 'Searching for an allowed Sothwark postcode' do
    visit '/search'
    fill_in 'postcode', with: 'SE1 7QD'
    click_button 'Look up Postcode'
    expect(page).to have_content 'Hurrah'
  end

  scenario 'Searching for an allowed Lambeth postcode' do
    visit '/search'
    fill_in 'postcode', with: 'SW2 5JD'
    click_button 'Look up Postcode'
    expect(page).to have_content 'Hurrah'
  end

  scenario 'Searching for a not found postcode' do
    visit '/search'
    fill_in 'postcode', with: 'SH24 1AA'
    click_button 'Look up Postcode'
    expect(page).to have_content 'Hurrah'
  end

  scenario 'Searching with empty params' do
    visit '/search'
    fill_in 'postcode', with: ''
    click_button 'Look up Postcode'
    expect(page).to have_content 'You must supply a postcode'
  end
end
