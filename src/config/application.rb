require_relative "boot"
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hangartalk
  class Application < Rails::Application
    config.load_defaults 6.1
    # ブラウザ側でJavaScriptが無効になっていた場合（Ajaxリクエストが送れない場合）でもうまく動くように
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    # デフォルトの言語を日本語にする
    config.i18n.default_locale = :ja
    # i18nの複数ロケールファイルが読み込まれるようpathを通す
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
  end
end
