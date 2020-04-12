# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def create_users
    20.times do 
        User.create(name: Faker::Name.unique.first_name, password: "123123123")
    end
end

def create_events
    @users = User.all
    @users.length.times do |n|
        # create an event for a given user. I skip event validations because event DateTime cannot be in the past, however I was to populate my DB with events that are in the past and future. 
        @users[n].events.new(event_name: Faker::Company.industry + " - networking event" , date_and_time: Faker::Time.between_dates(from: Date.today - 300, to: Date.today + 100, period: :all)).save(validate: false)
    end
end

#returns an array of unique numbers inside of a given range. This method is for when you want an array of x amount of unique numbers between a given range. Example: I want an array of 30 numbers. Every number in that array needs to be a unique number between 45..90. So I call unique_random(45..90, 30). 
#I use this method in add_attendees_to_events so this way I can add only unique attendees to events.
def unique_random(range, max)
    max = max > range.max ? range.max : max 
    randoms = Set.new
    until randoms.length >= max
        randoms << rand(range)
    end
    randoms.to_a
end

def add_attendees_to_events
    @events = Event.all
    @users = User.all
    @events.each do |event|

        # number of guests that will be attending this particular event. 
        number_of_attendees = rand(0...@users.count) 

        # an arr of random numbers used as indicies for grabbing used from User.all. I want to users to be unique. I dont want "Tammy" showing up twice on the guest list. 
        attendee_indicies = unique_random(0...@users.count, number_of_attendees) 

        # add attendees to this particular event. 
        number_of_attendees.times do |n|
            event.attendees << @users[attendee_indicies[n]]
        end
    end
end




create_users
create_events
add_attendees_to_events