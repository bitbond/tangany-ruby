module Tangany
  module Customers
    class WalletLinksResource < Resource
      BASE_PATH = "wallet-links"

      def create(**params)
        contract_hash = sanitize_params!(params)
        WalletLink.new(post_request(BASE_PATH, body: prepare_create_hash(contract_hash).to_json).body)
      end

      def delete(wallet_link_id)
        delete_request("#{BASE_PATH}/#{wallet_link_id}")
      end

      def list(**params)
        Collection.from_response(get_request(BASE_PATH, params: sanitize_params!(params)), type: WalletLink)
      end

      def retrieve(wallet_link_id)
        WalletLink.new(get_request("#{BASE_PATH}/#{wallet_link_id}").body)
      end

      private

      def prepare_create_hash(hash)
        # TODO: derive wallet address from secp256k1 public key instead of using the Custody API
        if hash[:wallet].present?
          custody_client = Tangany::Custody::Client.new
          wallet_status = custody_client.wallet_statuses(asset_id: hash[:assetId]).retrieve(hash[:wallet])
          hash[:address] = wallet_status.address
          hash.delete(:wallet)
        end
        hash
      end
    end
  end
end
