class DoorKeysController < ApplicationController

  def index
    @door_keys = DoorKey.paginate :page => params[:page], :order => 'created_at desc', :per_page => 20
  end

  def show
    @door_key = DoorKey.find_by_id(params[:id])
    if @door_key.nil?
      flash[:error] = "The door key does not exist"
      redirect_to door_keys_path
    end
  end

  def new
    @door_key = DoorKey.new
  end

  def create
    @door_key = DoorKey.new(params[:door_key])
    if @door_key.save
      flash[:success] = "Door keys successfully saved"
      redirect_to door_keys_path
    else
      flash.now[:error] = "The was not created"
      render 'new'
    end
  end

  def edit
    @door_key = DoorKey.find_by_id(params[:id])
    if @door_key.nil?
      flash[:error] = "The door key was not found"
      redirect_to door_keys_path
    end
  end

  def update
    @door_key = DoorKey.find_by_id(params[:id])
    if @door_key.present? && @door_key.update_attributes(params[:door_key])
      flash[:success] = "Door key correctly udpated"
      redirect_to door_keys_path
    else
      flash.now[:error] = "Door key could not be updated"
      render 'edit'
    end
  end

  def destroy
    @door_key = DoorKey.find_by_id(params[:id])
    if @door_key.present? && @door_key.destroy
      flash[:success] = "Door key successfully deleted"
      redirect_to door_keys_path
    else
      flash[:error] = "The door key could not be deleted"
      redirect_to request.referrer
    end
  end

end
