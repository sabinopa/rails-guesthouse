class HomeController < ApplicationController 
  def index
    @guesthouses = Guesthouse.all
      if host_signed_in?
        @guesthouse = current_host.guesthouse 
      end
  end
end