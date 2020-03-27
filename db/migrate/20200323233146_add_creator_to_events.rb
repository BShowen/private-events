class AddCreatorToEvents < ActiveRecord::Migration[6.0]
  def change
    add_reference :events, :creator, foreign_key: { to_table: :users }
    # add_column :events, :creator_id, :integer
    # add_foreign_key :events, :users, column: :creator_id
  end
end
