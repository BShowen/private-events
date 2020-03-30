# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

names = ['adam','erik','bradley','tayler','warren','greg','shane','kyle','brent','kaylee']

9.times do |n|
    User.create(name:"#{names[n]}", password:"password")
end

def add_guests(event)
    event.attendees << User.where("name != ?", event.creator.name)
end

9.times do |n|
    @user = User.all[n]
    @user.events.new(  event_name: "Event by #{@user.name}", 
                                        event_date: Time.parse( "2019-08-08" ), 
                                        event_time: Time.zone.now+n.hours ).save( validate: false )
    add_guests(@user.events.first)
    @user.events.create(  event_name: "Event by #{@user.name}", 
                                            event_date: Time.parse( "2030-09-20" ), 
                                            event_time: Time.zone.now-n.hours )
    add_guests(@user.events.second)
end