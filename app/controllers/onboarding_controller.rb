class OnboardingController < BaseController
  def index
    @organization = current_tenant || current_user.organizations.new(organization_params)

    if request.patch?
      @organization.attributes = organization_params

      if @organization.save!
        current_user.organizations << @organization
        redirect_to root_path and return
      end
    end
  end

  private

  def organization_params
    params.permit({ organization: [:name] })[:organization]
  end
end
