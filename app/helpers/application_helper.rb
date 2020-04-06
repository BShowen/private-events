module ApplicationHelper
    def current_user
        cookie = cookies.signed[:user_id]
        @current_user ||= User.find_by(id: cookie) if cookie 
    end

    def page_title
        if logged_in?
            "#{current_user.name.capitalize} | Private Events"
        else
            "Private Events"
        end
    end
end
