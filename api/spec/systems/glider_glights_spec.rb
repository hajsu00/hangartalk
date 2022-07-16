require 'rails_helper'
require 'gliderflights_helper'

RSpec.describe Gliderflight, type: :system do
  describe 'logged in user' do
    before do
      user = create(:user)
      user.confirm
      user.avatar.attach(io: File.open(Rails.root.join('app/assets/images/t_kyab.jpg')), filename: 't_kyab.jpg')
      user.user_cover.attach(io: File.open(Rails.root.join('app/assets/images/test/user_test_cover/user_test_cover_4.jpg')), filename: 'user_test_cover_4.jpg')
      create(:glider_initial_log, user: user)
      sign_in user
      @glider_type = create(:aircraft_type)
      @takeoff_time = Time.current
    end
    it 'should get new_gliderflight_path' do
      get new_gliderflight_path
      expect(response).to have_http_status 200
    end
    context 'with valid value' do
      it 'glider flight can be registered' do
        visit new_gliderflight_path
        fill_in 'gliderflight[date]', with: Date.today
        select 'ASK21', from: 'gliderflight_aircraft_type_id'
        select 'JA21MA', from: 'gliderflight[glider_ident]'
        fill_in 'gliderflight[departure_point]', with: '宝珠花滑空場'
        fill_in 'gliderflight[takeoff_time]', with: @takeoff_time
        fill_in 'gliderflight[release_alt]', with: '400'
        fill_in 'gliderflight[number_of_landing]', with: 1
        fill_in 'gliderflight[arrival_point]', with: '宝珠花滑空場'
        fill_in 'gliderflight[landing_time]', with: @takeoff_time + 6
        choose 'ウインチ曳航'
        choose '機長'
        check '野外飛行'
        fill_in 'gliderflight[note]', with: '備考欄です。'
        click_button '登録する'
        expect(Gliderflight.all).to change{ Gliderflight.all.size }.by(1)
        expect(current_path).to eq gliderflights_path
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