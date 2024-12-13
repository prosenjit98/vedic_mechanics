class IngredientsController < ApplicationController
  before_action :set_nav_filter
  before_action :set_ingredient, only: %i[ show]

  # GET /ingredients or /ingredients.json
  def index
    @ingredients = Ingredient.all
    @ingredients = @ingredients.search(params[:ing_search]) if params[:ing_search].present?
  end

  # GET /ingredients/1 or /ingredients/1.json
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end
end
