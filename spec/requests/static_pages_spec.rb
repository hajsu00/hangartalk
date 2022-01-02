require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  before do
    @base_title = 'Hanger Talk'
  end
  context 'GET #root' do
    before do
      get root_path
    end
    it 'should respond top_page successfully' do
      expect(response).to have_http_status 200
    end
    it 'has title: "Hanger Talk"' do
      expect(response.body).to include "#{@base_title}"
    end
  end

  context 'GET #about' do
    before do
      get about_path
    end
    it 'should respond successfully' do
      expect(response).to have_http_status 200
    end
    it 'has title: "Hanger Talkとは？ | Hanger Talk"' do
      expect(response.body).to include "Hanger Talkとは？ | #{@base_title}"
    end
  end

  context 'GET #faq' do
    before do
      get faq_path
    end
    it 'should respond successfully' do
      expect(response).to have_http_status 200
    end
    it 'has title: "よくある質問 | Hanger Talk"' do
      expect(response.body).to include "よくある質問 | #{@base_title}"
    end
  end

  context 'GET #inquiry' do
    before do
      get inquiry_path
    end
    it 'should respond successfully' do
      expect(response).to have_http_status 200
    end
    it 'has title: "お問合せ | Hanger Talk"' do
      expect(response.body).to include "お問合せ | #{@base_title}"
    end
  end

  context 'GET #policy' do
    before do
      get policy_path
    end
    it 'should respond successfully' do
      expect(response).to have_http_status 200
    end
    it 'has title: "プライバシーポリシー | Hanger Talk"' do
      expect(response.body).to include "プライバシーポリシー | #{@base_title}"
    end
  end
end
