class DoorsController < ApplicationController

  def index
     @doors = Door.paginate :page=>params[:page], :order => 'name desc', :per_page => 10
  end

  def show
    @door = Door.find_by_id(params[:id])
    if @door.nil?
      flash[:error] = "That door does not exist"
      redirect_to doors_path
    end
  end

  def new
    @door = Door.new
  end

  def edit
    @door = Door.find_by_id(params[:id])
    if @door.nil?
      flash[:error] = "Door not found"
      redirect_to doors_path
    else
      render 'edit'
    end
  end

  def update
    @door = Door.find_by_id(params[:id])
    p "something printed"
    p @door
    if @door.present? && @door.update_attributes(params[:door])
      p @door
      flash.now[:success] = "Door successfully updated"
      redirect_to doors_path
    else
      flash[:error] = "Door not deleted"
      redirect_to request.referrer
    end
  end

  def create
    @door = Door.new(params[:door])
    if @door.save
      flash[:success] = "Door #{@door.name} has been added"
      redirect_to doors_path
    else
      flash.now[:error] = "Unable to save your agreement"
      render 'new'
    end
  end

  def update
    @door = Door.find_by_id(params[:id])
    if @door.present? && @door.update_attributes(params[:door])
      flash.now[:success] = "Door updated successfully"
      redirect_to doors_path
    else
      flash[:error] = "Door could not be updated"
      render 'edit'
    end
  end

  def destroy
    @door = Door.find_by_id(params[:id])
    if @door.present? && @door.destroy
      flash[:success] = "Door successfully destroyed"
      redirect_to doors_path
    else
      flash[:error] = "Could not delete the Door"
      redirect_to request.referrer
    end
  end
end
