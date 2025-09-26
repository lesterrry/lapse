# frozen_string_literal: true

module Users
  class ReauthenticationController < DeviseController
  include Devise::Passkeys::Controllers::ReauthenticationControllerConcern
  include RelyingParty

  def set_relying_party_in_request_env
    request.env[relying_party_key] = relying_party
  end
  end
end
