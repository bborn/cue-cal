class EventsController < BaseController
  respond_to :html, :json

  inherit_resources
  belongs_to :production, optional: true
  before_action :turbo_frame_request_variant

  def flyout
    @event = resource
  end

  def create
    create! do |success, failure|
      success.html { |html|
        html.turbo_frame { }
        html.html {
          redirect_to event_path(@event), notice: "Event was successfully created."
        }
      }
      failure.html { render :new, status: :unprocessable_entity }
    end
  end

  def destroy
    destroy! do |success, failure|
      success.html { |html|
        html.turbo_frame {
          render action: :flyout and return
        }
        html.html {
          redirect_to events_url, notice: "Event was successfully destroyed."
        }
      }
      failure.html { render :edit, status: :unprocessable_entity }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    params.permit(event: [:start_time, :end_time, :name, :description, :production_id, location_ids: [], group_ids: []])
  end

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end
end
