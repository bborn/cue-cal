class GroupsController < BaseController
  inherit_resources
  belongs_to :production, optional: true

  def permitted_params
    params.permit(group: [:name, :color, :icon, production_ids: []])
  end
end
