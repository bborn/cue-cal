class OrganizationMembershipsController < BaseController
  respond_to :html, :json
  inherit_resources

  def index
    @search = collection.includes(:user).ransack(user_email_or_user_name_cont: params[:q])
    @organization_memberships = @search.result

    respond_to do |format|
      format.html {
        @organization_memberships = @organization_memberships.page(params[:page]).per(30)
      }
      format.json { render json: @organization_memberships, include: :user }
    end
  end

  def begin_of_association_chain
    current_tenant
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    params.permit(organization_membership: [:user_id, group_ids: []])
  end
end
