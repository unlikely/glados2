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
      flash[:success] = "Contract was successfully updated."
      redirect_to possession_contracts_path
    else
      flash[:error] = "We were unable to save your contract udpate"
      redirect_to new_possession_contract_path, :possession_contract => @possession_contract
    end
  end

  def edit
    @possession_contract = PossessionContract.find_by_id(params[:id])
    if @possession_contract.nil?
      flash[:error] = "The contract you are looking for was not found."
      redirect_to possession_contracts_path
    end
  end

  def update
    @possession_contract = PossessionContract.find_by_id(params[:id])
    if @possession_contract.present? && @possession_contract.update_attributes(params[:possession_contract])
      flash[:success] = "Contract sucessfully updated"
      redirect_to possession_contracts_path
    else
      flash[:error] = "The contract was not updated please try again"
      redirect_to edit_possession_contract_path(@possession_contract)
    end
  end

  def destroy
    @possession_contract = PossessionContract.find_by_id(params[:id])
    if @possession_contract.present? && @possession_contract.destroy && @possession_contract.destroyed?
      flash[:success] = "Contract successfully deleted"
      redirect_to possession_contracts_path
    else
      flash[:error] = "Contract not deleted please try it again"
      redirect_to request.referrer
    end
  end

end
