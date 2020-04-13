# Ruby on Rails - Associations Project
This is an application where you can sign up/sign in to create events, invite other users to your events, and accept or decline invites to other user's events. It's a simple application but I tried to make it relatively secure and without any bugs. 

I am currently following the curriculum at [The Odin Project](https://www.theodinproject.com "The Odin Project"). Everything I know is because of the people who run that program. Go check it out!

**Please submit a pull request to inform me of any bugs or if you have found and fixed any bugs. :)** 

## The models involved in this application
I have a User model, Event model, EventManifest model, and an Invitation model. The main models here are the User, Event, and Invitation models. The EventManifest model is a join table for Users and Events. The Invitation model is used to track invitations from User to User.
## User model
**Validations**  
The User model makes use of simple validations to ensure a user's name and password are present upon creation. The name is also validated to ensure uniqueness. I use a simple [callback](https://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html "Rails API") to format the name of the user **before saving** to the DB. In future iterations users will be required to sign up with an email address. Uniqueness of the name will be removed and applied to the email address column. 
**Password**  
I take advantage of Rails [has_secure_password](https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password "Rails API") feature to handle the password column of the user table. 

## Event model
**Validations**  
The Event model makes use of simple validations to ensure that the event has an event name, a date, a time, and that the time is not in that past. 

## Invitation model
The Invitation model is used only to record when a user sends an Invitation to antoher user to attend a specific event. There are four main columns that I use in the Invitation table: invite_id, invite_sender_id, invite_receiver_id, and event_id. The  fifth column is called 'accepted' which holds a boolean value. In the future, when a user declines an invite, I will keep the invitation stored in the table with an 'accepted' value as false. This way the invite_sender wont be able to send the invite_receiver another invitation to this particular event. Currently when a user declines an invitation the invitation sender can resend the invitation. 

## How I handle Associations
* **Users who create Events.**  
My association in the User model looks like this ``has_many :events, foreign_key: :creator_id`` and in the Event model it looks like this ``belongs_to :creator, class_name: "User"``. A user **has many** Events and an Event **belongs to** a User. In the User model I declare that the user **has many** events so that ```@user.events``` returns a list of events associated with that user. On the other side of the relationship, in the Events model, I declare that an Event **belongs to** a User. More specifically, it belongs to a creator who is simply a User. I want to be able to call ``@event.creator`` to get the User who created the event. 

* **Users who are attending Events.**  
This relationship uses a join table to bridge the relationship between the attendee (a User) and the Event. An attendee (User) can attend many events and an Event can have many attendees. I use a join table called EventManifest. An EventManifest **belongs to** an attendee and also **bleongs to** an Event.

* **Users who send Invitations to other Users to attend an Event**  
A User can send an invitation to another User. So the relationship says that a User **has many** Invitations as "invites_sent" and "invites_received". An Invitation **belongs to** an "invite_sender" and an "invite_receiver". There are multiple things happening here.  
    * The User who sent an Invitation is called an "invite_sender". The Invitation ``belongs_to :invite_sender, class_name: "User"``
    * The user who received an Invitation is called an "invite_receiver". The Invitation ``belongs_to :invite_receiver, class_name: "User"`` 
    * The Invitation also belongs to the Event that you invited the user to. This is a simple ``belongs_to :event`` statement in the Invitation model.
Now I can call ```@user.invites_sent``` and ```@user.invites_received``` to get a list of the invites. I use something very similar to ```@user.invites_received``` to add an Invites link to the top navigation only when the logged in user has invites.  

    **Some important logic**  
    When a user receives an invite they can either accept or decline it.  
    * If they accept the invitation
        1) That invitation accepter is added to the event's attendtee list: ```@event.attenddees << current_user```
        2) The invitation is removed from the Invitation table since its no longer needed.  
    * If they decline the invite
        1) The invitation is simply removed from the Invitation table.  

    Youll see why this explanation is important in the paragraph below. 


* **Events that have Invites**  
When a user sends an invite to another user this gets recorded in the Invitations table, as explained above. Now when you view that event you can see a list of users who have been invited but have not yet accepted/declined the invitation. When you view an event and you will see **Accepted invitations** and **Pending invitations** with lists of users. This is possible because ```@event.attendees``` is a list of users who can only be added to this list by accepting an invitation and ```@event.invited``` is a list of users who have been invited but havent responded to the invitation. 

## That's it for now
That covers everything I want to exaplain in this application. I'm sure there are better ways to do what I've done here but I am still learning. In the future I'll revisit this application and style it probably with [bootstrap](https://getbootstrap.com/, "Bootstrap") or something else if I'm feeling [Sass](https://sass-lang.com/, "Sass")y. For now this project is considered complete according to [The Odin Project](https://www.theodinproject.com/courses/ruby-on-rails/lessons/associations#project-private-events, "project-private-events") and I'm moving on in the curriculum.  

## To-Do
* Add unit tests
* Add integration tests