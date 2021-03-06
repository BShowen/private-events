class User < ApplicationRecord
    has_many :events, foreign_key: :creator_id, dependent: :destroy

    has_many :event_manifests, foreign_key: :attendee
    has_many :attended_events, through: :event_manifests, dependent: :destroy

    has_many :invites_sent, class_name: "Invitation", foreign_key: :invite_sender_id, dependent: :destroy
    has_many :invites_received, class_name: "Invitation", foreign_key: :invite_receiver_id, dependent: :destroy

    validates :name, presence: true
    has_secure_password
    validates :name, uniqueness: true
    before_save :format_name


    def sorted_events(future: false, past: false)
        if future 
            @upcoming_events ||= self.events.where("date_and_time > :current_time", {current_time: Time.zone.now})
        elsif past
            @past_events ||= self.events.where("date_and_time < :current_time", {current_time: Time.zone.now})
        end
    end

    def previously_attended_events
        @events ||= self.attended_events.where("date_and_time < :current_time", {current_time: Time.zone.now})
    end

    def event_owner?(event)
        self.events.include?(event)
    end

    def upcoming_attended_events
        @my_events ||= self.attended_events.where("date_and_time > :current_time", {current_time: Time.zone.now})
    end

    private
    def format_name
        self.name.downcase!
    end
end
