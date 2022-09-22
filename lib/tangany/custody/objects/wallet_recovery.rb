module Tangany
  module Custody
    class WalletRecovery < Object
      attribute :recoveryId, Types::String
      attribute :scheduledPurgeDate, Types::DateTime

      to_datetime :scheduledPurgeDate
    end
  end
end
