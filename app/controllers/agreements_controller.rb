class AgreementsController < ApplicationController
  respond_to :html, :json

  def index
    @agreement = Agreement.all
  end

  def show
    @agreement = Agreement.find_by_id(params[:id])
    if @agreement.nil?
      flash[:error] = "The Agreement does not exist"
      redirect_to agreements_path
    end
  end

  def new
   @agreement = Agreement.new
  end

  def create
    @agreement = Agreement.new(params[:agreement])
    if @agreement.save
      flash[:success] = "Agreement #{@agreement.name} has been added"
      redirect_to agreements_path
    else
      flash[:error] = "We were unable to save your agreement"
      redirect_to new_agreement_path, :agreement => @agreement
    end
  end

  def edit
    @agreement = Agreement.find_by_id(params[:id])
    if @agreement.nil?
      flash[:error] = "The agreement could not be found"
      redirect_to agreements_path
    else
      render 'edit'
    end
  end

  def update
    Rails.logger.info("PARAMS: #{params.inspect}")
    @agreement = Agreement.find_by_id(params[:id])
    if @agreement.present? && @agreement.update_attributes(params[:agreement])
      flash.now[:success] = "Your agreement was updated"
    else
      flash.now[:error] = "The agreement you are trying to update does not exist"
    end
      respond_with(@agreement, :location => agreements_path)
  end

  def destroy
    @agreement = Agreement.find_by_id(params[:id])
    if @agreement.present? && @agreement.destroy
      flash[:success] = "Agreement successfully deleted"
      redirect_to agreements_path
    else
      flash[:error] = "Agreement not deleted"
      redirect_to request.referrer
    end
  end

end
