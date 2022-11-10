class ProductionsController < BaseController
  inherit_resources

  def calendar
    @productions = Production.all
    @calendar = resource
  end

  def permitted_params
    params.permit(production: [:name, :user_id])
  end
end
