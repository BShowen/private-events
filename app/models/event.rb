class Event < ApplicationRecord
    # has_many :guests, through: :event_manifests, source: :attendee <-- The only reason I would use this line is if I wanted to retreive the people coming to a party by calling 'event.guests'. This line of code says that the 'event' has many 'guests' and in order to find those guests in the table we need to be looking under the column 'attendee'. Now if the column in the table was named 'guests' then we wouldnt need to include 'source: :attendee'. Remeber, source: is the "foreign_key" option for through tables. 
    belongs_to :creator, class_name: "User"
    has_many :event_manifests, foreign_key: :attended_event
    has_many :attendees, through: :event_manifests
    has_many :invited, class_name: :Invitation, foreign_key: :event_id

    validates :event_name, presence: true
    validates :event_date, presence: true
    validates :event_time, presence: true
    validate :event_cannot_be_in_past

    scope :past, -> { where("event_time < :current_time", { current_time: Time.zone.now }) }
    scope :upcoming, -> { where("event_time > :current_time", { current_time: Time.zone.now }) }

    def date_of_event #overwrite the default getter method
        self[:event_date].strftime("%B %e %Y")
    end

    def time_of_event
        self[:event_time].strftime("%I\:%M%P")
    end

    private
    def event_cannot_be_in_past
        if (event_date.present? && event_time.present?) 
            return if event_date > Time.zone.now
            errors.add(:event, "cannot be in the past")
        end
    end
end