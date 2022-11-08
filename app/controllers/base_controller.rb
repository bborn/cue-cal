class BaseController < ApplicationController
  before_action :authenticate_user!
  set_current_tenant_through_filter
  before_action :set_current_organization
end
