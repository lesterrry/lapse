# frozen_string_literal: true

module Users
  class PasskeysController < DeviseController
  include Devise::Passkeys::Controllers::PasskeysControllerConcern
  include RelyingParty

  # disable reauth
  def verify_reauthentication_token; end

  def user_details_for_registration
    { id: resource.webauthn_id || WebAuthn.generate_user_id, name: resource.email }
  end

  def set_relying_party_in_request_env
    request.env[relying_party_key] = relying_party
  end
  end
end
