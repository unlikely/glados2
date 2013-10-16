class EquipmentController < ApplicationController
  def index
    @equip = Equipment.paginate :page=>params[:page], :order => 'make desc', :per_page => 10
  end

  def show
    @equip = Equipment.find_by_id(params[:id])
    if @equip.nil?
      flash.now[:error] = "The Equipment you are looking for does not exist"
      redirect_to equipment_path
    end
  end

  def new
    any_equip = params[:equip]
    if any_equip.nil?
      @equip = Equipment.new
    else
      @equip = Equipment.new(any_equip)
    end
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
      flash[:success] = "#{@equip.make} was successfully created"
      redirect_to equipment_index_path
    else
      flash.now[:error] = "We were unable to save your equipment"
      render 'new'
    end
  end

  def update
    @equip = Equipment.find_by_id(params[:id])
    if @equip.present? && @equip.update_attributes(params[:equipment])
      flash[:success] = "Equipment successfully updated"
      redirect_to equipment_index_path
    else
      flash.now[:error] = "The equipment was not updated please try inputing again"
      render 'edit'
    end
  end

  def destroy
    @equip = Equipment.find_by_id(params[:id])
    if @equip.present? && @equip.destroy && @equip.destroyed?
      flash[:success] = "Equipment successfully deleted"
      redirect_to equipment_index_path
    else
      flash.now[:error] = "Equipment could not be found or deleted"
      redirect_to request.referrer
    end
  end
end
