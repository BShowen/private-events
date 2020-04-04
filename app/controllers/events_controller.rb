class EventsController < ApplicationController
    def new
        @event = Event.new
    end

    def create 
        @event = current_user.events.build(event_params)
        if @event.save
            redirect_to @event
        else
            render :new
        end
    end

    def show
        @event = Event.find_by(id: params[:id])
    end

    def index
        @events = Event.all
    end

    private
    def event_params
        params[:event][:date_and_time] = parse_datetime
        params.require(:event).permit(:event_name, :date_and_time)
    end

    def parse_datetime
        month = params[:event].delete("date_and_time(2i)")
        day = params[:event].delete("date_and_time(3i)")
        year = params[:event].delete("date_and_time(1i)")
        hour = params[:event].delete("date_and_time(4i)")
        minute = params[:event].delete("date_and_time(5i)")
        Time.new(year, month, day, hour, minute)
    end 
end