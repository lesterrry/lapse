class CommonPagesController < ApplicationController
	def index
		@page_nav_name = 'home'
	end

	def promo
		@page_nav_name = 'promo'
	end

	def about
		@page_nav_name = 'about'
	end

	def search; end
end
