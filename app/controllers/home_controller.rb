class HomeController < ApplicationController
  def health_check
    head :ok
  end
end