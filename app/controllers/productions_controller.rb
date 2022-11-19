class ProductionsController < BaseController
  inherit_resources

  def calendar
    @productions = Production.all
    @calendar = resource
  end

  def first_calls
    @production = resource

    @user_calls = @production.first_user_calls
  end

  def show
    redirect_to action: :calendar
  end

  def copy_from_date
    @production = resource
    @date = DateTime.parse((params[:date] || Date.today)).in_time_zone - 1.day

    events = @production.events.on(@date)
    events.each do |event|
      # duplicate the event
      new_event = event.dup
      new_event.start_time = new_event.start_time + 1.day
      new_event.end_time = new_event.end_time + 1.day
      new_event.locations = event.locations
      new_event.groups = event.groups
      new_event.save!
    end

    redirect_to calendar_production_path(@production, date: @date.to_date + 1.day)
  end

  protected

  def begin_of_association_chain
    current_user
  end

  def permitted_params
    params.permit(production: [:name])
  end
end
