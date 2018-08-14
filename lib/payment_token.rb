class PaymentToken
  def self.authorize()
    unix_timestamp = Time.now.to_i.to_s
    paymentez_server_application_code = ENV['PAYMENTEZ_SERVER_CODE']
    paymentez_server_app_key = ENV['PAYMENTEZ_SERVER_KEY']
    uniq_token_string = paymentez_server_app_key + unix_timestamp
    uniq_token_hash = Digest::SHA256.hexdigest(uniq_token_string)
    auth_token = paymentez_server_application_code + ';' + unix_timestamp + ';' +  uniq_token_hash 
    final = Base64.encode64(auth_token).gsub("\n", "")
  end
end