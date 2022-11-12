class Users::InvitationsController < Devise::InvitationsController
  before_action :authenticate_user!
  set_current_tenant_through_filter
  before_action :set_current_organization
  before_action :configure_permitted_parameters

  private

  def after_invite_path_for(inviter, invitee)
    organization_memberships_path
  end

  def invite_resource
    if user = User.where(email: invite_params[:email]).first
      user.organizations << current_tenant unless user.organizations.include?(current_tenant)
      user.invite!(current_user)
      user
    else
      super { |user|
        user.organizations << current_tenant
        user
      }
    end
  end

  # Permit the new params here.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:email, :name])
  end
end
