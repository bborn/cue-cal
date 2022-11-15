class OrganizationMembershipsController < BaseController
  inherit_resources

  def begin_of_association_chain
    current_tenant
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    params.permit(organization_membership: [:user_id, group_ids: []])
  end
end
