class CategoriesController < ApplicationController

  def index
    @categories = Category.all.order :name
    @start_date = filter_params.blank? ? Transaction.order(:created_at).first.created_at : get_date[:start_date].to_date
    @end_date = filter_params.blank? ? Time.now : get_date[:end_date].to_date
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

  def get_date
    {
      start_date: "#{filter_params["from(1i)"]}-#{filter_params["from(2i)"]}-#{filter_params["from(3i)"]}",
      end_date: "#{filter_params["to(1i)"]}-#{filter_params["to(2i)"]}-#{filter_params["to(3i)"]}"
    }
  end

  private

  def filter_params
    return '' unless params[:date]
    params.require(:date).permit(:from, :to)
  end

  def category_params
    params.require(:category).permit(:name)
  end
end