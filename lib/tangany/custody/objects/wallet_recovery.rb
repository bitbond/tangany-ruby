module Tangany
  module Custody
    class WalletRecovery < Object
      attribute :recoveryId, Types::String
      attribute :scheduledPurgeDate, Types::String
    end
  end
end
