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

  def edit
    @possession_contract = PossessionContract.find_by_id(params[:id])
    if @possession_contract.nil?
      flash.now[:error] = "The contract you are looking for was not found."
      render :index
    end
  end

  def update
    @possession_contract = PossessionContract.find_by_id(params[:id])
    if @possession_contract.present? && @possession_contract.update_attributes(params[:possession_contract])
      flash.now[:success] = "Contract sucessfully updated"
      redirect_to possession_contract_path(@possession_contract)
    else
      flash.now[:error] = "The contract was not updated please try again"
      render :edit
    end
  end

  def destroy
    @possession_contract = PossessionContract.find_by_id(params[:id])
    if @possession_contract.present? && @possession_contract.destroy && @possession_contract.destroyed?
      flash.now[:success] = "Contract successfully deleted"
      redirect_to possession_contracts_path
    else
      flash.now[:error] = "Contract not deleted please try it again"
      redirect_to request.referrer
    end
  end


end
