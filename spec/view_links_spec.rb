require 'spec_helper'

feature "View" do
  scenario 'list of links' do
    Link.create(url: 'http://github.com', title: 'GitHub')
    visit '/links'
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content('GitHub')
    end
  end
end
