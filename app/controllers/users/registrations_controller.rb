# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    include ApplicationHelper
    include Devise::Passkeys::Controllers::RegistrationsControllerConcern
    include RelyingParty

    REGISTRATIONS_DISABLED = false

    def new
      if REGISTRATIONS_DISABLED
        flash[:notice] = 'New user registrations are temporarily disabled.'
        redirect_to root_path
      else
        super do
          @passkey_mode = params[:passkey] == '1'
          @hide_footer = true
        end
      end
    end

    def create
      if REGISTRATIONS_DISABLED
        flash[:notice] = 'New user registrations are temporarily disabled.'
        redirect_to root_path
      else
        build_resource(sign_up_params)

        resource.save

        if resource.persisted?
          create_passkey_for_resource(resource:)
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          flash[:error] = extract_errors(resource)

          redirect_to action: :new
        end
      end
    end

    def after_update_path_for(_resource)
      edit_user_registration_path
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
end
