class ServiceController < ApplicationController
    def locale
        redirect_back fallback_location: root_path
    end
end
