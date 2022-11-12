class OrganizationMembershipsController < BaseController
  inherit_resources

  # before_action :set_organization_membership, only: %i[ show edit update destroy ]

  # # GET /organization_memberships or /organization_memberships.json
  # def index
  #   @organization_memberships = OrganizationMembership.all.order(created_at: :desc)
  # end

  # # # GET /organization_memberships/1 or /organization_memberships/1.json
  # # def show
  # # end

  # # # GET /organization_memberships/new
  # # def new
  # #   @organization_membership = OrganizationMembership.new
  # # end

  # # GET /organization_memberships/1/edit
  # def edit
  # end

  # # # POST /organization_memberships or /organization_memberships.json
  # # def create
  # #   @organization_membership = OrganizationMembership.new(organization_membership_params)

  # #   respond_to do |format|
  # #     if @organization_membership.save
  # #       format.html { redirect_to organization_membership_url(@organization_membership), notice: "Organization membership was successfully created." }
  # #       format.json { render :show, status: :created, location: @organization_membership }
  # #     else
  # #       format.html { render :new, status: :unprocessable_entity }
  # #       format.json { render json: @organization_membership.errors, status: :unprocessable_entity }
  # #     end
  # #   end
  # # end

  # # PATCH/PUT /organization_memberships/1 or /organization_memberships/1.json
  # def update
  #   respond_to do |format|
  #     if @organization_membership.update(organization_membership_params)
  #       format.html { redirect_to organization_membership_url(@organization_membership), notice: "Organization membership was successfully updated." }
  #       format.json { render :show, status: :ok, location: @organization_membership }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @organization_membership.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /organization_memberships/1 or /organization_memberships/1.json
  # def destroy
  #   if @organization_membership.user == current_user
  #     redirect_to url_for(action: :index), notice: "Sorry, can't do that." and return
  #   end
  #   @organization_membership.destroy

  #   respond_to do |format|
  #     format.html { redirect_to organization_memberships_url, notice: "Organization membership was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  # private

  # # Use callbacks to share common setup or constraints between actions.
  # def set_organization_membership
  #   @organization_membership = OrganizationMembership.find(params[:id])
  # end

  def begin_of_association_chain
    current_tenant
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    params.permit(organization_membership: [:user_id, group_ids: []])
  end
end
