# frozen_string_literal: true

class ApplicationController < ActionController::Base
	before_action :set_locale

	protected

	def authenticate_user_from_token!
		auth_header = request.headers['Authorization']
		token = auth_header&.split(' ')&.last
		payload = JWT.decode(token, Rails.application.secret_key_base).first rescue nil

		if payload && payload['user_id']
			@current_user = User.find_by(id: payload['user_id'])
		end

		render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
	end

	def set_locale
		loc = extract_locale

		unless loc.nil?
			I18n.locale = loc
			cookies[:locale] = loc
		end
	end

	def extract_locale
		if !params[:locale].blank?
			parsed_locale = params[:locale]
		elsif !cookies[:locale].blank?
			parsed_locale = cookies[:locale]
		elsif !request.location.country_code.blank?
			parsed_locale = request.location.country_code.downcase
		elsif !request.env['HTTP_ACCEPT_LANGUAGE'].blank?
			parsed_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/)[0]
		else
			return nil
		end

		I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
	end
end
