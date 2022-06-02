require 'aws-sdk'

if Rails.application.credentials.db.present?
  Aws::Rails.add_action_mailer_delivery_method(
    :ses,
    credentials: Aws::Credentials.new(Rails.application.credentials.aws[:access_key_id],
                                      Rails.application.credentials.aws[:secret_access_key]),
    region: 'ap-northeast-1'
  )
else
  Aws::Rails.add_action_mailer_delivery_method(
    :ses,
    credentials: Aws::Credentials.new(AWS_ACCESS_KEY_ID,
                                      AWS_SECRET_ACCESS_KEY),
    region: 'ap-northeast-1'
  )
end