class CalendarChannel < ApplicationCable::Channel
  def subscribed
    stream_from "calendar_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
