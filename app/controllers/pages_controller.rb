class PagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin!

  def edit

  end

  def index

  end
end
