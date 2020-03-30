class EventsController < ApplicationController
    def new
        @event = Event.new
    end

    def create 
        # parse_event_time
        byebug
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
        params.require(:event).permit(:event_name, :event_date, :event_time)
    end

    def parse_event_time
        date = event_params[:event_date]
        time = event_params[:event_time]
        params[:event][:event_time] = Time.parse("#{date} #{time}")
    end
end
