class GroupMembershipsController < BaseController
  inherit_resources
  actions :create, :new, :destroy

  nested_belongs_to :production, :group

  def create
    @group = parent

    unless params[:group_membership][:user_email].blank? || @group.users.where(email: params[:group_membership][:user_email]).exists?
      group_membership = build_resource

      if user = current_tenant.users.find_by(email: params[:group_membership][:user_email])
        group_membership.organization_membership = current_tenant.organization_memberships.find_by(user_id: user)
      else
        #invite the user
        user = User.new(email: params[:group_membership][:user_email], name: params[:group_membership][:user_name])

        user.organizations << current_tenant
        user.invite!(current_user)

        group_membership.organization_membership = user.organization_memberships.find_by(organization_id: current_tenant.id)
      end
      group_membership.save!

      redirect_to production_group_path(@group.production, @group), notice: "User added to group."
    else
      redirect_to production_group_path(@group.production, @group), notice: "User is already in this group."
    end
  end

  def permitted_params
    params.permit(group_membership: [:user_email, :user_name])
  end
end
