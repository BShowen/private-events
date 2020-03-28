class AddAcceptedToInvitations < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :accepted, :boolean, default: :false
  end
end
