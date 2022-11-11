class LocationsController < BaseController
  inherit_resources
  respond_to :html, :json

  private

  def location_params
    params.require(:location).permit(:name, :icon, :color)
  end
end
