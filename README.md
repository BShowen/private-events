# Ruby on Rails - Associations Project
This is an application where you can sign up/sign in to create events, invite other users to your events, and accept or decline invites to other user's events. It's a simple application but I tried to make it relatively secure and without any bugs. 

I am currently following the curriculum at [The Odin Project](https://www.theodinproject.com "The Odin Project"). Everything I know is because of the people who run that program. Go check it out!

###### Please submit a pull request to inform me of any bugs or if you have found and fixed any bugs. :) 

## User model
#### Validations
The User model makes use of simple validations to ensure a user's name and password are present upon creation. The name is also validated to ensure uniqueness. I use a simple [callback](https://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html "Rails API") to format the name of the user **before saving** to the DB. In future iterations users will be required to sign up with an email address. Uniqueness of the name will be removed and applied to the email address column. 
#### Password
I take advantage of Rails [has_secure_password](https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password "Rails API") feature to handle the password column of the user table. 

## Event model
#### Validations
The Event model makes use of simple validations to ensure that the event has an event name, a date, a time, and that the time is not in that past. 

## How I handle Associations
#### Association between User and Event model
* Users who create Events.
    * This is a relatively straight forward association. A user **has many** Events and an Event **belongs to** a User. In the User model I declare that the user **has many** events so that ```@user.events``` returns a list of events associated with that user. On the other side of the relationship, in the Events model, I declare that an Event **belongs to** a User. More specifically, it belongs to a creator who is simply User. I want to be able to call ``@event.creator`` to get the User who created the event. My association in the Event model looks like this ``belongs_to :creator, class_name: "User"`` and in my User model it looks like this ``has_many :events, foreign_key: :creator_id``. 
* Users who are attending Events.
    * This relationship uses a join table to bridge the relationship between the attendee (a User) and the Event. An attendee (User) can attend many events and an Event can have many attendees. I use a join table called Event_manifest. An Event_manifest **belongs to** an attendee and also **bleongs to** an Event.
#### Association between between User and Invitation
A User can send an invitation to another User. So the relationship says that a User **has many** Invitations as "invites_sent" and "invites_received" Invitation **belongs to** an "invite_sender" and an "invite_receiver". There are multiple things happening here. 
1) The User who sent an Invitation is called an "invite_sender". The Invitation ``belongs_to :invite_sender, class_name: "User"``
2) The user who received an Invitation is called an "invite_receiver". The Invitation ``belongs_to :invite_receiver, class_name: "User"``
3) The Invitation also belongs to the Event your invited the person to. This is a simple ``belongs_to :event`` statement in the Invitation model. 
#### Association between between Event and Invitation
* An Event can have many Invitations
* An Invitation belongs to an Event

# TO-DO
* Fix event sorting logic. Right now when a user is logged in they see events under "events im attending" even if the event is in the past. These events should be categorized as "Events I've attended". 
* "Events im attending" should only include events in the future. 
* Rename "Upcoming events" to "My upcoming events"
* Rename "Past events" to "My past events"