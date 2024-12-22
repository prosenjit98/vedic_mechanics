class Admin::ProductsController < Admin::BaseController 
  before_action :find_by_id_product, only: [:show, :edit, :update, :destroy, :add_tags, :delete_image]
  before_action :add_breadcrumbs
  before_action :set_category, only: [:new, :create, :edit, :update]
  before_action :set_collections

  
  def index
    @products = Product.order(name: :asc).with_rich_text_specification
  end

  def show
    @product = Product.find_by_id(params[:id])
    breadcrumbs.add @product.name
  end
  
  def new
    @product = Product.new
    @product_variants = @product.product_variants.build
    breadcrumbs.add "new"
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to [:admin, @product], notice: "Product was successfully created."
    else
      render :new, alert: "There was an error creating the product."
    end
  end

  def edit
    @product_variants = @product.product_variants.build unless @product.product_variants.present?
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def update
    @product = Product.find_by_id(params[:id])
    respond_to do |format|
      if @product.update(product_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@product, partial: "admin/products/product", locals: {product: @product}) }
        format.html { redirect_to admin_products_path(@product), notice: "Product was successfully updated." }
      end
    end
  end

  def destroy 
    @product.destroy
    # redirect_to admin_products_path
  end 

  def add_tags
  end

  def update_tags
    @product.tag_list = params[:product][:tag_list]
    if @product.save
      redirect_to admin_products_path
    end
  end

  def delete_image
    if @product.product_images.find(params[:file_id]).purge
      redirect_to admin_product_path(@product), notice: "Image was successfully deleted."
    else
      redirect_to admin_product_path(@product), notice: "Image successfully deleted."
    end
  end


  private
  
  def set_category
    @categories = Category.left_joins(:child_categories).group('categories.id').having('COUNT(child_categories_categories.id) = 0')
  end
  def find_by_id_product
    @product = Product.find_by_id(params[:id])
  end

  def product_params
    params[:product][:concern_ids].reject!(&:blank?) if params[:product][:concern_ids].present?
    params[:product][:ingredient_ids].reject!(&:blank?) if params[:product][:ingredient_ids].present?
    params[:product][:categories_ids].reject!(&:blank?) if params[:product][:categories_ids].present?
    params.require(:product).permit(:name, :product_code, :price, :description, :tag_list, :vendor_id, :hsn, :specification, :stock_quantity, :original_price, :discount, :mfg_cost,:approx_delivery_cost, product_images: [], product_variants_attributes: [:product_id, :variant_id, :value, :id], category_ids: [],concern_ids: [], ingredient_ids: [])
  end

  def add_breadcrumbs
    # breadcrumbs.add "Admin"
    breadcrumbs.add "Products", admin_products_path
  end

  def set_collections
    @concerns = Concern.all
    @ingredients = Ingredient.all
  end


end
