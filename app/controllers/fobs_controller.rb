class FobsController < ApplicationController

  def index
    @fobs = Fob.paginate :page => params[:page], :per_page => 20
  end

  def show
    @fob = Fob.find_by_id(params[:id])
    if @fob.nil?
      flash[:error] = "Fob not found"
      redirect_to fobs_path
    end
  end

  def new
    @fob = Fob.new
  end

  def create
    @fob = Fob.new(params[:fob])
    if @fob.save
      flash[:success] = "Fob with #{@fob.key} has been added"
      redirect_to fobs_path
    else
      flash.now[:error] = "Unable to save this fob"
      render 'new'
    end
  end

  def edit
    @fob = Fob.find_by_id(params[:id])
    if @fob.nil?
      flash[:error] = "The fob could not be found"
      redirect_to fobs_path
    else
      render 'edit'
    end
  end

  def update
    @fob = Fob.find_by_id(params[:id])
    if @fob.present? && @fob.update_attributes(params[:fob])
      flash.now[:success] = "Fob successfully updated"
      redirect_to fobs_path
    else
      flash.now[:error] = "Unable to update fob"
      render 'edit'
    end
  end

  def destroy
    @fob = Fob.find_by_id(params[:id])
    if @fob.present? && @fob.destroy
      flash[:success] = "Fob successfully deleted"
      redirect_to fobs_path
    else
      flash[:error] = "Could not delete fob"
      redirect_to request.referrer
    end
  end
end
