class CalendarController < BaseController
  def index
    @productions = Production.all
  end
end
