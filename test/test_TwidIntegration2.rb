# frozen_string_literal: true

require "test_helper"

class TestTwidIntegration2 < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::TwidIntegration2::VERSION
  end

  def test_it_does_something_useful
    # PaymentViaRewards.FetchRewardsBalanceFromTwid(9599701483, 1, 200)
    # assert false
  end
end
