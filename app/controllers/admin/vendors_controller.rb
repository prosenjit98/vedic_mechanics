class Admin::VendorsController < Admin::BaseController 
  before_action :set_admin_vendor, only: %i[ show edit update destroy ]

  # GET /admin/vendors or /admin/vendors.json
  def index
    @admin_vendors = Vendor.all
  end

  # GET /admin/vendors/1 or /admin/vendors/1.json
  def show
  end

  # GET /admin/vendors/new
  def new
    @admin_vendor = Vendor.new
  end

  # GET /admin/vendors/1/edit
  def edit
  end

  # POST /admin/vendors or /admin/vendors.json
  def create
    @admin_vendor = Vendor.new(admin_vendor_params)

    respond_to do |format|
      if @admin_vendor.save
        format.html { redirect_to admin_vendors_path, notice: "Vendor was successfully created." }
        format.json { render :show, status: :created, location: @admin_vendor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/vendors/1 or /admin/vendors/1.json
  def update
    respond_to do |format|
      if @admin_vendor.update(admin_vendor_params)
        format.html { redirect_to admin_vendors_url, notice: "Vendor was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_vendor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/vendors/1 or /admin/vendors/1.json
  def destroy
    @admin_vendor.destroy!

    respond_to do |format|
      format.html { redirect_to admin_vendors_url, notice: "Vendor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_vendor
      @admin_vendor = Vendor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_vendor_params
      params.require(:vendor).permit(:name, :address)
    end
end
