class CategoriesController < ApplicationController

  def index
    @categories = Category.all.order :name
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes category_params
      redirect_to categories_path, notice: "Category was successfully updated."
    else
      render :edit
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to categories_path, notice: "Category was successfulyy created."
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end