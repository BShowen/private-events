module InvitationsHelper
    def current_user_has_invites
        current_user.invites_received.any? {|invite| !invite.accepted? }
    end
end
