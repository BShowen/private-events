class CreateEventManifests < ActiveRecord::Migration[6.0]
  def change
    create_table :event_manifests, id: false do |t|
      t.references :attendee
      t.references :attended_event
    end
  end
end
