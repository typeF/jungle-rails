class Admin::DashboardController < ApplicationController

  # before_filter :authorize
  before_filter :authenticate


  def show
  end
end
