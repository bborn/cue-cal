class ApplicationController < ActionController::Base
  def set_current_organization
    return unless current_user.present?

    if params[:organization_id]
      current_organization = current_user.organizations.find(params[:organization_id])
    else
      if !current_user.organizations.any?
        redirect_to onboarding_path and return
      end
      current_organization = current_user.organizations.first
    end
    ActsAsTenant.current_tenant = current_organization
  end
end
