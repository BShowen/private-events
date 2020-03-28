class InvitationsController < ApplicationController
    def index
        @invitations = current_user.invites_received
    end

    def create
        @event = Event.find_by(id: invite_params[:event_id])
        @sender = current_user
        @receiver = User.find_by(id: invite_params[:invite_receiver])
        @invite = Invitation.new(invite_sender: @sender, invite_receiver: @receiver, event: @event)
        @invite.save
        redirect_back(fallback_location: root_path)
    end

    def update
        @invite = Invitation.find_by(id: params[:id])
        @invite.update_attribute(:accepted, true)
        if current_user_has_invites
            redirect_to invitations_path 
        else
            redirect_to current_user
        end
    end

    private
    def invite_params
        params.require(:invitation).permit(:invite_sender, :invite_receiver, :event_id)
    end
end
