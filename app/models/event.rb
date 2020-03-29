class Event < ApplicationRecord
    # has_many :guests, through: :event_manifests, source: :attendee <-- The only reason I would use this line is if I wanted to retreive the people coming to a party by calling 'event.guests'. This line of code says that the 'event' has many 'guests' and in order to find those guests in the table we need to be looking under the column 'attendee'. Now if the column in the table was named 'guests' then we wouldnt need to include 'source: :attendee'. Remeber, source: is the "foreign_key" option for through tables. 
    belongs_to :creator, class_name: "User"
    has_many :event_manifests, foreign_key: :attended_event
    has_many :attendees, through: :event_manifests
    has_many :invited, class_name: :Invitation, foreign_key: :event_id

    validates :event_name, presence: true
    validates :date, presence: true
    validate :date_cannot_not_be_in_the_past

    scope :past, -> { where("date < :current_time", { current_time: Time.now}) }
    scope :upcoming, -> { where("date > :current_time", { current_time: Time.now }) }

    def formatted_date #overwrite the default getter method
        self[:date].strftime("%B %e %Y at %I\:%M%P")
    end

    private
    def date_cannot_not_be_in_the_past
        if date.present? && date < Time.now.midnight
            errors.add(:date, "cannot be in the past")
        end
    end
end
