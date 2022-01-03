require 'rails_helper'

RSpec.describe 'layout links', type: :system do
  context 'not logged in' do
    it 'should open top page' do
      visit root_path
      expect(page).to have_title 'Hanger Talk'
    end
    it 'should open about page' do
      visit about_path
      expect(page).to have_title 'Hanger Talkとは？ | Hanger Talk'
    end
  end
end
