class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_category, only: %i[ show ]

  # GET /categories or /categories.json
  def index
    @categories = Category.all
    render json: @categories
  end

  def show
    render json: @category
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
    # Use callbacks to share common setup or constraints between actions.
    # def set_category
    #   @category = Category.find(params.expect(:id))
    # end

    # # Only allow a list of trusted parameters through.
    # def category_params
    #   params.expect(category: [ :category ])
    # end
end
