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

  def permitted_params
    params.permit(production: [:name, :user_id])
  end
end
