class Admin::CategoriesController < Admin::BaseController 
  before_action :set_category, only: %i[ show edit update destroy update_position ]
  before_action :set_parents, only: %i[ new edit create update ]
  before_action :add_breadcrumbs


  def index
    @categories = Category.all
    @mother_categories = Category.parent_categories.order(position: :asc)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_categories_path, notice: "Category was successfully created." }
        # format.json { render :show, status: :created, location: @category }
        format.turbo_stream do
          flash.now[:notice] = "Created!"
          render turbo_stream: [turbo_stream.after(:categories, partial: "admin/categories/category", locals: { category: @category }), turbo_stream.remove("admin_modal")]
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_categories_url, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
        format.turbo_stream do
          flash.now[:notice] = "Updated!"
          render turbo_stream: turbo_stream.replace("category-#{@category.id}", partial: "admin/categories/new_category", locals: { category: @category })
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy!

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = "Deleted!"
        render turbo_stream: turbo_stream.remove("category-#{@category.id}")
      end
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update_position
    @category.insert_at(params[:position].to_i + 1)
  end

  private
    def set_category
      @category = Category.find_by_id(params[:id])
    end

    def set_parents
      @parents = Category.active.left_joins(:products).active.group(:id).having('COUNT(products.id) = 0').distinct.order(:name)
      @parents = @parents.where.not(id: @category.id) if @category.present?
    end
    
    def add_breadcrumbs
      breadcrumbs.add "Categories", admin_categories_path
    end
    def category_params
      params.require(:category).permit(:name, :description, :parent_category_id, :is_active)
    end
end
