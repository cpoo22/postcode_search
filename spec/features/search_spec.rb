# frozen_string_literal: true

feature 'Search' do
  scenario 'Has a search page' do
    visit '/search'
    expect(page).to have_content 'Search'
  end
end
