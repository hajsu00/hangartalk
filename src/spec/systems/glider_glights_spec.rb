require 'rails_helper'
require 'glider_flights_helper'

RSpec.describe GliderFlight, type: :system do
  describe 'logged in user' do
    before do
      user = create(:user)
      user.confirm
      user.avatar.attach(io: File.open(Rails.root.join('app/assets/images/t_kyab.jpg')), filename: 't_kyab.jpg')
      user.user_cover.attach(io: File.open(Rails.root.join('app/assets/images/test/user_test_cover/user_test_cover_4.jpg')), filename: 'user_test_cover_4.jpg')
      create(:glider_initial_log, user: user)
      sign_in user
      @glider_type = create_list(:aircraft_type, 3)
    end
    it 'should get new_glider_flight_path' do
      get new_glider_flight_path
      expect(response).to have_http_status 200
    end
    context 'with valid value' do
      it 'glider flight can be registered' do
        visit new_glider_flight_path
        fill_in 'glider_flight[date]', with: Date.today
        # find("#glider_flight_aircraft_type_id").find("option[value='ASK_4']").select_option
        select 'ASK_4', from: '航空機の型式'
        select 'JA21MA', from: 'glider_flight[glider_ident]'
        fill_in 'glider_flight[departure_point]', with: '宝珠花滑空場'
        fill_in 'glider_flight[takeoff_time]', with: Time.current
        fill_in 'glider_flight[release_alt]', with: '400'
        fill_in 'glider_flight[number_of_landing]', with: 1
        fill_in 'glider_flight[arrival_point]', with: '宝珠花滑空場'
        fill_in 'glider_flight[landing_time]', with: Time.current + 6
        choose 'ウインチ曳航'
        choose '機長'
        check '野外飛行'
        fill_in 'glider_flight[note]', with: '備考欄です。'
        click_button '登録する'
        expect(GliderFlight.all).to change{ GliderFlight.all.size }.by(1)
        expect(current_path).to eq glider_flights_path
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