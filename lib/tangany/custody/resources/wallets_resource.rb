module Tangany
  module Custody
    class WalletsResource < Resource
      def list(**params)
        params[:index] = params.delete(:start) if params[:start]
        params[:tags] = serialize_tags(params[:tags])
        params[:xtags] = serialize_tags(params[:xtags])
        Collection.from_response(get_request("wallets", params: params), type: Wallet)
      end

      private

      def serialize_tags(tags)
        tags.present? ? tags.join(",") : nil
      end
    end
  end
end
