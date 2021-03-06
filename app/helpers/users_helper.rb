module UsersHelper
    def uninvited_users(event) #return a list of users that are not invited to the provided event
        invited_users = event.invited.includes(:invite_receiver).map(&:invite_receiver)
        invited_users += event.attendees.to_a
        uninvited_users = User.where("name != :current_user_name", {current_user_name: current_user.name}).to_a
        uninvited_users.delete_if do |user|
            invited_users.include?(user) 
        end
        uninvited_users
    end
end
