require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HangerTalkPrototype
  class Application < Rails::Application
    config.load_defaults 6.1
    # ブラウザ側でJavaScriptが無効になっていた場合（Ajaxリクエストが送れない場合）でもうまく動くように
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
