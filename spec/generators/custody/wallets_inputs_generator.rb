module Tangany
  module Custody
    class WalletsInputsGenerator
      attr_reader :inputs_root_folder, :responses_root_folder

      def initialize
        @inputs_root_folder = "spec/fixtures/generated/inputs/custody/wallets"
        @responses_root_folder = "spec/fixtures/generated/responses/custody/wallets"
      end
    end
  end
end
