module Tangany
  module Custody
    class WalletStatusesResource < Resource
      def retrieve(wallet_id)
        WalletStatus.new(get_request("#{@chain["base_path"]}/wallet/#{wallet_id}").body)
      end
    end
  end
end
