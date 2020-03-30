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
        concate_date_and_time
        params.require(:event).permit(:event_name, :event_date, :event_time)
    end

    def concate_date_and_time
        datetime = "#{params[:event][:event_date]} #{params[:event][:event_time]}"
        params[:event][:event_date] = datetime
        params[:event][:event_time] = datetime
    end
end
