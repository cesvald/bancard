module Bancard
  class Gateway
    attr_accessor :public_key, :shop_process_id, :private_key

    def initialize(auth_params = {})
      @public_key      = auth_params.fetch(:public_key)
      @shop_process_id = auth_params.fetch(:shop_process_id)
      @private_key     = auth_params.fetch(:private_key)
    end

    def single_buy(params = {})
      init = single_buy_init(params)
      submit_single_buy_init(init)
    end

    private

    def single_buy_init(params = {})
      Bancard::SingleBuyInit.new(merge_auth_params(params))
    end

    def submit_single_buy_init(init)
      url      = Bancard.vpos_url(Bancard::SingleBuyInit::ENDPOINT)
      response = Typhoeus.post(url, body: init.request_params)
      Bancard::SingleBuyInitResponse.new response
    end

    def merge_auth_params(hash)
      hash.merge(public_key: public_key, private_key: private_key, shop_process_id: shop_process_id)
    end
  end
end
