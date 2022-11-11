class EventsController < BaseController
  respond_to :html, :json

  inherit_resources
  belongs_to :production, optional: true

  # before_action :set_event, only: %i[ show flyout edit update destroy ]

  # # GET /events or /events.json
  # def index
  #   @events = Event.all
  # end

  # # GET /events/1 or /events/1.json
  # def show
  #   if params[:flyout]
  #     render template: "shared/resource/flyout_show", locals: { resource: @event }
  #   end
  # end

  # # GET /events/new
  # def new
  #   @event = Event.new(event_params)
  #   if params[:flyout]
  #     render template: "shared/resource/flyout_new", locals: { resource: @event }
  #   end
  # end

  # # GET /events/1/edit
  # def edit
  #   respond_to do |format|
  #     format.html { }
  #   end
  # end

  # # POST /events or /events.json
  # def create
  #   @event = Event.new(event_params)

  #   respond_to do |format|
  #     if @event.save
  #       format.html {
  #         redirect_to event_path(@event, flyout: params[:flyout]), notice: "Event was successfully created."
  #       }
  #       format.json { render :show, status: :created, location: @event }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @event.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def create
    create! do |success, failure|
      success.html {
        redirect_to event_path(@event, flyout: params[:flyout]), notice: "Event was successfully created."
      }
      failure.html { render :new, status: :unprocessable_entity }
    end
  end

  # # PATCH/PUT /events/1 or /events/1.json
  # def update
  #   respond_to do |format|
  #     if @event.update(event_params)
  #       format.html {
  #         redirect_to event_url(@event), notice: "Event was successfully updated."
  #       }
  #       format.json { render :show, status: :ok, location: @event }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @event.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def update
  #   update! do |success, failure|
  #     success.html {
  #       redirect_to event_url(@event, flyout: params[:flyout]), notice: "Event was successfully updated."
  #     }
  #     failure.html { render :edit, status: :unprocessable_entity }
  #   end
  # end

  # # DELETE /events/1 or /events/1.json
  # def destroy
  #   @event.destroy

  #   respond_to do |format|
  #     format.html {
  #       redirect_url = events_url

  #       if params[:flyout]
  #         render template: "shared/resource/flyout_destroy", locals: { resource: @event } and return
  #       else
  #         redirect_to redirect_url, notice: "Event was successfully destroyed."
  #       end
  #     }
  #     format.json { head :no_content }
  #   end
  # end

  def destroy
    destroy! do |success, failure|
      success.html {
        if params[:flyout]
          render template: "shared/resource/flyout_destroy", locals: { resource: @event } and return
        else
          redirect_to events_url, notice: "Event was successfully destroyed."
        end
      }
      failure.html { render :edit, status: :unprocessable_entity }
    end
  end

  # private

  # # Use callbacks to share common setup or constraints between actions.
  # def set_event
  #   @event = Event.find(params[:id])
  # end

  # Only allow a list of trusted parameters through.
  def permitted_params
    params.permit(event: [:start_time, :end_time, :name, :description, :production_id, location_ids: [], group_ids: []])
  end
end
