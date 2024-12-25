# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include Devise::Passkeys::Controllers::RegistrationsControllerConcern
  include RelyingParty

  def new
    super do
      @passkey_mode = params[:passkey] == '1'
    end
  end

  # disable reauth
  def verify_reauthentication_token; end

  # disable fields validation
  def require_email_and_passkey_label; end

  def passkey_create?
    params&.dig(:action) == 'create' && params&.dig(resource_name, :passkey_credential).present?
  end

  def create_passkey(resource:)
    return unless passkey_create?

    resource.passkeys.create!(
      label: passkey_params[:passkey_label],
      public_key: @webauthn_credential.public_key,
      external_id: Base64.strict_encode64(@webauthn_credential.raw_id),
      sign_count: @webauthn_credential.sign_count,
      last_used_at: Time.now.utc
    )
  end

  def verify_passkey_registration_challenge
    return unless passkey_create?

    @webauthn_credential = verify_registration(relying_party:)
  rescue ::WebAuthn::Error => e
    error_key = Warden::WebAuthn::ErrorKeyFinder.webauthn_error_key(exception: e)
    render json: { message: find_message(error_key) }, status: :bad_request
  end
end
