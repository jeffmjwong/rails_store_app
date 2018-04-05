class PurchasesController < ApplicationController
  before_action :check_admin, only: [:show, :new]
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit]

  def index
    @purchases = Purchase.where(:cart_id => current_user.cart.id)
  end

  def show
  end

  def new
    @purchase = Purchase.new
  end

  def edit
  end

  def create
    @purchase = Purchase.new(purchase_params)
    # Check to see if item already exits in shopping cart
    if Purchase.find_by(cart_id: @purchase.cart_id, product_id: @purchase.product_id) == nil
      respond_to do |format|
        if @purchase.save
          update_stockvolume(@purchase, -1)
          format.html { redirect_to purchases_path, notice: 'Purchase was successfully created.' }
          format.json { render :show, status: :created, location: @purchase }
        else
          format.html { render :new }
          format.json { render json: @purchase.errors, status: :unprocessable_entity }
        end
      end
    else
      @purchase = Purchase.find_by(cart_id:@purchase.cart_id, product_id:@purchase.product_id)
      @purchase.quantity += 1
      @purchase.save

      update_stockvolume(@purchase, -1)

      redirect_to purchases_path
    end
  end

  def update
    respond_to do |format|
      old_quantity = @purchase.quantity
      if @purchase.update(update_params)
        update_stockvolume(@purchase, old_quantity - @purchase.quantity)
        format.html { redirect_to purchases_path, notice: 'Purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    update_stockvolume(@purchase, @purchase.quantity)
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: 'Purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    def update_params
      params.require(:purchase).permit(:cart_id, :product_id, :quantity)
    end

    def purchase_params
      params.permit(:cart_id, :product_id, :quantity)
    end

    def update_stockvolume(purchase, quantity)
      product = Product.find(purchase.product_id)
      product.stockvolume = product.stockvolume + quantity
      product.save
    end

    def check_admin
      if !current_user.admin
        redirect_to home_path_url
      end
    end

    def check_user
      if current_user != @purchase.cart.user
        redirect_to home_path_url
      end
    end
end
