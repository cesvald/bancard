require 'digest/md5'
require 'typhoeus'
require 'json'
require 'uri'
require 'bancard/version'
require 'bancard/utils'
require 'bancard/single_buy_init'
require 'bancard/single_buy_init_response'
require 'bancard/gateway'

module Bancard
  TEST_URL = 'https://vpos.infonet.com.py:8888'
  LIVE_URL = 'https://vpos.infonet.com.py'

  DEFAULT_CURRENCY = 'PYG'

  def self.test=(value)
    @test = !!value
  end

  def self.test?
    !!@test
  end

  def self.vpos_url(path = nil)
    uri      = URI.parse(test? ? TEST_URL : LIVE_URL)
    uri.path = path.to_s
    uri.to_s
  end
end
