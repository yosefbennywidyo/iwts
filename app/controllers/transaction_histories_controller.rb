class TransactionHistoriesController < ApplicationController
  before_action :set_transaction_history, only: %i[ show edit update destroy ]

  # GET /transaction_histories or /transaction_histories.json
  def index
    @transaction_histories = TransactionHistory.all
  end

  # GET /transaction_histories/1 or /transaction_histories/1.json
  def show
  end

  # GET /transaction_histories/new
  def new
    @transaction_history = TransactionHistory.new
  end

  # GET /transaction_histories/1/edit
  def edit
  end

  # POST /transaction_histories or /transaction_histories.json
  def create
    @transaction_history = TransactionHistory.new(transaction_history_params)

    respond_to do |format|
      if @transaction_history.save
        format.html { redirect_to transaction_history_url(@transaction_history), notice: "Transaction history was successfully created." }
        format.json { render :show, status: :created, location: @transaction_history }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transaction_histories/1 or /transaction_histories/1.json
  def update
    respond_to do |format|
      if @transaction_history.update(transaction_history_params)
        format.html { redirect_to transaction_history_url(@transaction_history), notice: "Transaction history was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction_history }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transaction_histories/1 or /transaction_histories/1.json
  def destroy
    @transaction_history.destroy

    respond_to do |format|
      format.html { redirect_to transaction_histories_url, notice: "Transaction history was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction_history
      @transaction_history = TransactionHistory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_history_params
      params.fetch(:transaction_history, {})
    end
end
