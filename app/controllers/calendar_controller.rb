class CalendarController < BaseController
  def show
    @productions = Production.all
  end
end
