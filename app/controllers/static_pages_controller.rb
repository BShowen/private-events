class StaticPagesController < ApplicationController
    skip_before_action :authorize
    def home
        render "static_pages/home"
    end
end
