class Admin::PaymentsController < Admin::BaseController
  before_action :set_payment, only: %i[ show edit update]

  # GET /payments or /payments.json
  def index
    @payments = Payment.all.order(created_at: :desc)
  end

  # GET /payments/1 or /payments/1.json
  def show
  end

  # GET /payments/new
  # def new
  #   @payment = Payment.new
  # end

  # GET /payments/1/edit
  def edit
  end

  def update
    respond_to do |format|
      if payment_params['status'] == 'captured'
        if @payment.capture!
          @payment.touch(:captured_at)
          format.html { redirect_to admin_payments_url, notice: "Payment was successfully updated." }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      else
        if @payment.update(payment_params)
          format.html { redirect_to admin_payments_url, notice: "Payment was successfully updated." }
          format.json { render :show, status: :ok, location: @payment }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @payment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:order_id, :amount, :payment_method, :status)
  end


end