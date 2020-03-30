module SessionsHelper
    def log_in(user)
        cookies.permanent.signed[:user_id] = user.id
    end

    def logged_in?
        current_user ? true : false
        # user_id = cookies.permanent.signed[:user_id]
        # if User.find_by(id: user_id) 
        #     true
        # else
        #     false
        # end
    end
    
    def log_out
    cookies.delete :user_id
    end
end
