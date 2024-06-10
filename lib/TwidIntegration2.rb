# frozen_string_literal: true

require_relative "TwidIntegration2/version"
require 'payment_via_rewards'  # Assuming the library name is payment_via_rewards

module TwidIntegration2
  class Error < StandardError; end
  puts "Hello Jyamiti"
  puts PaymentViaRewards.FetchRewardsBalanceFromTwid(9811719998, 1, 1000)
  opt_rewards_redeem_args = {}
  opt_rewards_redeem_args["card_bin"] = 531849
  opt_rewards_redeem_args["last_4"] = 1234
  opt_rewards_redeem_args["auth_code"] = 12
  opt_rewards_redeem_args["arn"] = 12
  puts opt_rewards_redeem_args
  puts PaymentViaRewards.RedeemPoints(9811719998, 1000, "m1",
                                      261379, 500, 1, "burn",
                                      "CC", opt_rewards_redeem_args)

  # Your code goes here...
end
