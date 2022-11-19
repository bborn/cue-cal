class LocationsController < BaseController
  inherit_resources
  belongs_to :production, optional: true

  respond_to :html, :json

  def create
    create! do |success, failure|
      success.html {
        if Location.all.count.eql?(1) && @production
          redirect_to @production and return
        else
          super
        end
      }
    end
  end

  private

  def permitted_params
    params.permit(:production_id, location: [:name, :icon, :color])
  end
end
