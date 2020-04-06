class InvitationsController < ApplicationController
    def index
        @invitations = current_user.invites_received
    end

    def create
        if params[:invitation].nil?  #redirects a potentially malicious invitation.
            flash[:notice] = "Something went wrong."
            redirect_to current_user || root_url and return
        end
        @event = Event.find_by(id: session[:event_id])
        @sender = current_user
        @receiver = User.find_by(id: invite_params[:invite_receiver])
        @invite = Invitation.new(invite_sender: @sender, invite_receiver: @receiver, event: @event)
        @invite.save
        session.clear
        redirect_back(fallback_location: root_path)
    end

    def update
        @invite = Invitation.find_by(id: session[:invite_id])
        @event_owner = @invite.invite_sender
        @event = @invite.event
        @event.attendees << current_user
        @invite.destroy
        flash[:notice] = "Invite accepted."
        properly_redirect
    end

    def destroy
        @invite = Invitation.find_by(id: session[:invite_id])
        session.clear
        if @invite && current_user.id == @invite.invite_receiver.id
            flash[:notice] = "Event has been declined."
            @invite.destroy
            properly_redirect
        else
            flash[:notice] = "Something went wrong. Try again."
            redirect_to current_user
        end 
    end

    private
    def invite_params
        params.require(:invitation).permit(:invite_sender, :invite_receiver, :event_id)
    end

    def properly_redirect #redirect to invites if the user has more invites otherwise redirect to the users account page
        if current_user_has_invites
            redirect_to invitations_path 
        else
            redirect_to current_user
        end
    end
end
