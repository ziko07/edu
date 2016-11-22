class WelcomeController < ApplicationController
  def index
    @categories = Category.all.order('position asc')
  end
end
