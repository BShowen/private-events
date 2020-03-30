# README

Things I need to  fix

<!-- 1) any user can view an event and invite people. only event hosts should be able to invite people.  -->

<!-- 2) add date field to event form.  -->

3) When a user accepts an invite he needs to be added to the events "accepted users" list. same thing with declined users. 

4) an events show page should display the list of invited users, a list of accepted users, a list of declined users. 

5) I want to also display a list of users who have declined to go to the event. Maybe add a column to the invite (delined:boolean) that can be used for this logic. 

6) When an event has passed you should not be able to invite anyone to it. 

<!-- 7) I need to add flash alerts.  -->

8) app crashes when you try to show an event that doesnt exist. this is because the app finds the event based on the query parameter event_id which can be forged. My current controller config allows this and blindy accepts the query param and searches the DB for an event with that id. if it doesnt exist then @event is nil but it still loads the view which crashes with a nil event. 

<!-- 9) add time column to events.  -->

<!-- 10) change date column in events to hold ony the date without the time.  -->

<!-- 11) Dont allow events to be created in the past.  -->

<!-- 12) sort the past and upcoming  events by the date and the time -->

<!-- 13) update seed to properly create events with this new time column -->

<!-- 14) form errors should be a shared partial layout to DRY code -->

15) Account page should show accepted events and declined events