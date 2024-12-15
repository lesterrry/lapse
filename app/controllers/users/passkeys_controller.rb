# frozen_string_literal: true

class Users::PasskeysController < DeviseController
  include Devise::Passkeys::Controllers::PasskeysControllerConcern
  include RelyingParty

  # disable reauth
  def verify_reauthentication_token; end

  def set_relying_party_in_request_env
    request.env[relying_party_key] = relying_party
  end
end
