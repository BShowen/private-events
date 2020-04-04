# README

Things I need to  fix

<!-- 1) any user can view an event and invite people. only event hosts should be able to invite people.  -->

<!-- 2) add date field to event form.  -->

<!-- 3) When a user accepts an invite he needs to be added to the events "attendees" list -->

4) an events show page should display the list of invited users, and a list of accepted users. 

6) When an event has passed you should not be able to invite anyone to it. 

<!-- 7) I need to add flash alerts.  -->

8) app crashes when you try to show an event that doesnt exist. this is because the app finds the event based on the query parameter event_id which can be forged. My current controller config allows this and blindy accepts the query param and searches the DB for an event with that id. if it doesnt exist then @event is nil but it still loads the view which crashes with a nil event. Add a flash[:notice] = "event not found" and redirect to account page. 

<!-- 9) add time column to events.  -->

<!-- 10) change date column in events to hold ony the date without the time.  -->

<!-- 11) Dont allow events to be created in the past.  -->

<!-- 12) sort the past and upcoming  events by the date and the time -->

<!-- 13) update seed to properly create events with this new time column -->

<!-- 14) form errors should be a shared partial layout to DRY code -->

15) Account page should show accepted events.

<!-- 16) when a user accepts/declines an invite you need to delete the invite from the DB.  -->

<!-- • Event date and time can be concatenated into one column and then parsed when you read and write.  -->

• Currently you can send an empty invite and it breaks the app. Fix this