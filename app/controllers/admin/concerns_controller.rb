class Admin::ConcernsController < Admin::BaseController
  before_action :set_concern, only: %i[ show edit update  ]
  before_action :add_breadcrumbs

  def index
    @concerns = Concern.all
  end

  def show
  end

  def new
    @concern = Concern.new
  end
  
  def create
    @concern = Concern.new(concern_params)
    respond_to do |format|
      if @concern.save
        format.html { redirect_to admin_concerns_path, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @concern }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @concern.errors, status: :unprocessable_entity }
      end
    end
  end



  def edit
  end

  def update
    def update
      respond_to do |format|
        if @concern.update(concern_params)
          format.html { redirect_to admin_concerns_path, notice: "Concern was successfully updated." }
          format.json { render :show, status: :ok, location: @concern }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @concern.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  def set_concern
    @concern = Concern.find(params[:id])
  end

  def concern_params
    params.require(:concern).permit(:name, :description, :image)
  end

  def add_breadcrumbs
    breadcrumbs.add "Concerns", admin_concerns_path
  end


end