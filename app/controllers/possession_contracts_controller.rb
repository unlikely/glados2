class PossessionContractsController < ApplicationController
  def index
    @possession_contracts = PossessionContract.all
  end

  def show
    @possession_contract = PossessionContract.find_by_id(params[:id])
    if @possession_contract.nil?
      flash.now[:error] = "The contract you are looking for does not exist please try again"
      redirect_to possession_contracts_path
    end
  end

  def new
    @possession_contract = PossessionContract.new
  end

  def create
    @possession_contract = PossessionContract.new(params[:possession_contract])
    if @possession_contract.save
      flash.now[:success] = "Contract was successfully updated."
      render 'show'
    else
      flash.now[:error] = "We were unable to save your contract udpate"
      render 'new'
    end
  end

end