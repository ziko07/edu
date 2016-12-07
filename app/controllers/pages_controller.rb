class PagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin!

  def edit
    @page = SeoPage.find_by_id(params[:id])
  end

  def index
    @pages = SeoPage.all
  end

  def update
    page = SeoPage.find_by_id(params[:id])
    if page.update_attributes(page_params)
      flash[:success] = 'Page has been updated successfully'
    else
      flash[:danger] = 'Something wrong please try again!'
    end
    redirect_to edit_page_path(page)
  end

  protected

  def page_params
    params.require(:seo_page).permit!
  end

end
