# frozen_string_literal: true
require 'uri'
require 'net/http'

class PaymentViaRewards
  def self.SetRequestTwidCredentials (request, request_body)
    hmacKey = 'a17da57f6afb440386d7f37b3e0f4ed5171644036983163ead36299e9b460ca59b0a6c9391fec317164403698316'
    request["brand-key"] = 'CdWG8g7pff2q2rnWfGIv3hfC7kF7EV4cd3gRUg5hPsYP15Q4VKClbuIPuF2Ro2jW'
    request["access-token"] = '0f9f8e07cc3e448fa45b4da81614836917164403678859b253a35009b545e392298a487a46f92c17164403678859'
    request["hmac"] =  OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA256.new, hmacKey, request_body)
  end
  def self.FetchRewardsBalanceFromTwid (contact_num, session_id, amount)
    url = URI("https://api.dev.twidapp.com/v1/ms2s/fetchBalance")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["accept"] = 'application/json'
    request_body = "{\"optional_fields\":{\"applicable_bin_list\":1},\"bill_amount\":#{amount},
      \"mobile_number\":#{contact_num},\"session_id\":\"#{session_id}\"}"
    SetRequestTwidCredentials(request, request_body)
    request["Content-Type"] = 'application/json'
    request.body = request_body
    response = http.request(request)
    # puts response.read_body
    return response.read_body
  end

  def self.RedeemPoints(contact_num, amount, merchant_id, reward_id, reward_amount,
                    session_id, mode,payment_mode, opt_rewards_redeem_args )
    # voucher_id, voucher_amount, card_bin, last_4,  auth_code, arn
    url = URI("https://api.dev.twidapp.com/v1/ms2s/redeemPoints")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["accept"] = 'application/json'
    request.body =

    request_body = "{\"mobile_number\":#{contact_num},\"bill_amount\":#{amount},
      \"merchant_transaction_id\":\"#{merchant_id}\",\"reward_id\":#{reward_id},
      \"reward_amount\":#{reward_amount},\"payment_mode\":\"#{payment_mode}\",
      \"session_id\":\"#{session_id}\",\"mode\":\"#{mode}\""
    if(opt_rewards_redeem_args.has_key?("voucher_id"))
      request_body += ",\"voucher_id\":#{opt_rewards_redeem_args["voucher_id"]},
        \"voucher_amount\":#{opt_rewards_redeem_args["voucher_amount"]}"
    end
    if(payment_mode == "CC" || payment_mode == "DC")
      request_body += ",\"card_bin\":#{opt_rewards_redeem_args["card_bin"]},
        \"last_4\":#{opt_rewards_redeem_args["last_4"]},
        \"auth_code\":#{opt_rewards_redeem_args["auth_code"]},
        \"arn\":#{opt_rewards_redeem_args["arn"]}"
    end
    request_body += "}"
    puts request_body

    SetRequestTwidCredentials(request, request_body)
    request["Content-Type"] = 'application/json'
    request.body = request_body
    response = http.request(request)
    # puts response.read_body
    return response.read_body
  end
end
