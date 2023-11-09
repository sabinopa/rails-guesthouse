class HomeController < ApplicationController 
  def index
    @guesthouses = Guesthouse.active
      if host_signed_in?
        @guesthouse = current_host.guesthouse 
      end
    @recent_guesthouses = Guesthouse.active.last(3)
    @other_guesthouses = Guesthouse.active.order(created_at: :desc)[3..] || []
    @available_cities = Guesthouse.active.pluck(:city).uniq!
  end
end