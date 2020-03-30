class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :event_name
      t.datetime :event_date
      t.datetime :event_time

      t.timestamps
    end
  end
end
