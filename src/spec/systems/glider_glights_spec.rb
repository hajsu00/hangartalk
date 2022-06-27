require 'rails_helper'
require 'glider_flights_helper'

RSpec.describe GliderFlight, type: :system do
  describe 'logged in user' do
    before do
      user = create(:user)
      user.confirm
      user.avatar.attach(io: File.open(Rails.root.join('app/assets/images/t_kyab.jpg')), filename: 't_kyab.jpg')
      user.user_cover.attach(io: File.open(Rails.root.join('app/assets/images/test/user_test_cover/user_test_cover_4.jpg')), filename: 'user_test_cover_4.jpg')
      sign_in user
    end
    it 'should get new_glider_flight_path' do
      get new_glider_flight_path
      expect(response).to have_http_status 200
    end
    context 'with valid value' do
      it 'glider flight can be registered' do
        visit new_glider_flight_path
        fill_in 'glider_flight[date]', with: Date.today
        select @glider_type.aircraft_type.first, from: 'glider_flight[aircraft_type_id]'
        select 'JA21MA', from: 'glider_flight[glider_ident]'
        # fill_in 'glider_flight[aircraft_type_id]', with: 'ASK21'
        # fill_in 'glider_flight[glider_ident]', with: 'JA21MA'
        fill_in 'glider_flight[departure_point', with: '宝珠花滑空場'
        fill_in 'glider_flight[takeoff_time]', with: Time.current
        fill_in 'glider_flight[release_alt]', with: '400'
        fill_in 'glider_flight[number_of_landing]', with: 1
        fill_in 'glider_flight[arrival_point]', with: '宝珠花滑空場'
        fill_in 'glider_flight[landing_time]', with: Time.current + 6
        chose 'glider_flight_is_winch_true'
        chose 'glider_flight[flight_role]', value: '機長'
        check 'glider_flight_is_cross_country'
        fill_in 'glider_flight_note', with: '備考欄です。'
      end
    end
    context 'with invalid value' do
      it 'glider flight cannot be registered' do
  
      end
    end
  end
  describe 'not logged in user' do
    before do

    end
    it 'should redirect to ***' do

    end
  end
end