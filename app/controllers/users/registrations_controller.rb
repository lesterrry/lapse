# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include Devise::Passkeys::Controllers::RegistrationsControllerConcern
  include RelyingParty

  # disable reauth
  def verify_reauthentication_token; end
end
