class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :event_name
      t.datetime :date
      t.time :event_time

      t.timestamps
    end
  end
end
