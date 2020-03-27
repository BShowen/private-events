class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.references :invite_sender
      t.references :event
      t.references :invite_receiver
    end
  end
end
