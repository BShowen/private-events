class User < ApplicationRecord
    has_many :events, foreign_key: :creator_id

    has_many :event_manifests, foreign_key: :attendee
    has_many :attended_events, through: :event_manifests

    has_many :invites_sent, class_name: "Invitation", foreign_key: :invite_sender_id
    has_many :invites_received, class_name: "Invitation", foreign_key: :invite_receiver_id

    has_secure_password
    validates :name, presence: true
    validates :name, uniqueness: true

    before_save :format_name

    def previous_events
        @past_events = self.events.where("date < :current_time", {current_time: Time.zone.now})
    end

    def upcoming_events
        @upcoming_events = self.events.where("date > :current_time", {current_time: Time.zone.now})
    end

    def event_owner?(event)
        self.events.include?(event)
    end

    private
    def format_name
        self.name.downcase!
    end
end
