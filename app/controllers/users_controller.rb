class UsersController < BaseController
  # inherit_resources
  #   before_action :set_user, only: %i[ show edit update destroy ]

  #   def index
  #     # @users = current_tenant.users.all.order(id: :desc)
  #     @memberships = current_tenant.organization_memberships.all.order(id: :desc)
  #   end

  #   def edit
  #   end

  #   def update
  #     respond_to do |format|
  #       if @user.update(user_params)
  #         format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
  #         format.json { render :show, status: :ok, location: @user }
  #       else
  #         format.html { render :edit, status: :unprocessable_entity }
  #         format.json { render json: @user.errors, status: :unprocessable_entity }
  #       end
  #     end
  #   end

  #   private

  #   def set_user
  #     @user = current_tenant.users.find(params[:id])
  #   end

  #   def user_params
  #     params.permit({ user: [:email] })[:user]
  #   end
end
