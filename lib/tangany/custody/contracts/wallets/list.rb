module Tangany
  module Custody
    module Contracts
      module Wallets
        class List < ApplicationContract
          ALLOWED_ORDERS = ["created", "security", "updated", "wallet"].freeze

          schema do
            config.validate_keys = true

            optional(:start).filled(:integer, lt?: 10_000)
            optional(:limit).filled(:integer, gt?: 0, lteq?: 100)
            optional(:order).filled(:string, included_in?: ALLOWED_ORDERS)
            optional(:sort).filled(:string, included_in?: ALLOWED_SORTS)
            optional(:tags).filled(:array, min_size?: 1)
            optional(:xtags).filled(:array, min_size?: 1)
          end

          rule(:sort) do
            key.failure("should not be specified without `order`") if values[:sort].present? && values[:order].nil?
          end

          def to_safe_params!(params)
            safe_params = super(params)
            order = safe_params.delete(:order)

            safe_params[:sort] = order + (safe_params[:sort] == "desc" ? "desc" : "") if order
            safe_params[:index] = safe_params.delete(:start) if safe_params[:start]
            safe_params[:tags] = safe_params[:tags].join(",") if safe_params[:tags]
            safe_params[:xtags] = safe_params[:xtags].join(",") if safe_params[:xtags]
            safe_params
          end
        end
      end
    end
  end
end
