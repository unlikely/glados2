class EquipmentController < ApplicationController
  def index
    @equip = Equipment.all
  end

  def show
    @equip = Equipment.find_by_id(params[:id])
    if @equip.nil?
      flash.now[:error] = "The Equipment you are looking for does not exist"
      redirect_to equipment_path
    end
  end

  def new
    @equip = Equipment.new
  end

  def edit
   @equip = Equipment.find_by_id(params[:id])
   if @equip.nil?
     flash.now[:error] = "The equipment you are looking for was not found or the id was invalid"
     redirect_to equipment_path
   end
  end

  def create
    @equip = Equipment.new(params[:equipment])
    if @equip.save
      flash.now[:success] = "#{@equip.make} was successfully created"
      render 'show'
    else
      flash.now[:error] = "We were unable to save your equipment"
      render 'new'
    end
  end

  def update
    @equip = Equipment.find_by_id(params[:id])
    if @equip.present? && @equip.update_attributes(params[:equipment])
      flash.now[:success] = "Equipment successfully updated"
      redirect_to equipment_path
    else
      flash.now[:error] = "The equipment was not updated please try inputing again"
      render 'edit'
    end
  end

  def destroy
    @equip = Equipment.find_by_id(params[:id])
    if @equip.present? && @equip.destroy && @equip.destroyed?
      flash.now[:success] = "Equipment successfully deleted"
      redirect_to equipment_index_path
    else
      flash.now[:error] = "Equipment could not be found or deleted"
      redirect_to request.referrer
    end
  end
end
