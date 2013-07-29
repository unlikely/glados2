class EquipmentController < ApplicationController
  def index
    @equip = Equipment.all
  end

  def new
    @equip = Equipment.new
  end

  def create
    @equip = Equipment.new(params[:equip])
    if @equip.save
      flash.now[:success] = "Equipment successfully added"
      render :action => 'show', :id => @equip.id
    else
      flash.now[:error] = "Adding equipment failed due to missing or incorrect information!"
      render 'new'
    end
  end

  def show
    @equip = Equipment.find(params[:id])
    if @equip.nil?
      flash.now[:error] = "The Equipment you are looking for does not exist"
      render "index"
    else
      @equip
    end
  end
end
