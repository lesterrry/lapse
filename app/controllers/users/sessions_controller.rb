# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    include Devise::Passkeys::Controllers::SessionsControllerConcern
    include RelyingParty

    def set_relying_party_in_request_env
      request.env[relying_party_key] = relying_party
    end

    def new
      super do
        @hide_footer = true
      end
    end
  end
end
