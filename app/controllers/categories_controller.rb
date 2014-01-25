class CategoriesController < ApplicationController
  before_action :require_user, except: [:index, :show] 
  before_action :require_admin, only: [:new, :create]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find_by slug: params[:id]
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = 'Your category was created'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit!
  end

end