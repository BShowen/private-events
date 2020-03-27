class ApplicationController < ActionController::Base
    include SessionsHelper
    include ApplicationHelper
    before_action :authorize

    private
    def authorize
        unless logged_in?
            redirect_to root_path
        end
    end
end