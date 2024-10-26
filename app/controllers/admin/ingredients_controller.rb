class Admin::IngredientsController < Admin::BaseController
  before_action :set_ingredient, only: %i[ show edit update  ]
  before_action :add_breadcrumbs

  def index
    @ingredients = Ingredient.all
  end

  def show
  end

  def new
    @ingredient = Ingredient.new
  end
  
  def create
    @ingredient = Ingredient.new(ingredient_params)
    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to admin_ingredients_path, notice: "Ingredient was successfully created." }
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end



  def edit
  end

  def update
    def update
      respond_to do |format|
        if @ingredient.update(ingredient_params)
          format.html { redirect_to admin_ingredients_path, notice: "Ingredient was successfully updated." }
          format.json { render :show, status: :ok, location: @ingredient }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @ingredient.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :description)
  end

  def add_breadcrumbs
    breadcrumbs.add "Ingredients", admin_ingredients_path
  end
end
