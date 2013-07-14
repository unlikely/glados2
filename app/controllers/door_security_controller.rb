class DoorSecurityController < ApplicationController

  def open
    @doors  = Door.all
    @fobs   = Fob.all

    if(params.has_key?(:fob) && params.has_key?(:door))
      door  = Door.find(params[:door][:door_id])
      fob   = Fob.find(params[:fob][:fob_id])
      user = fob.user
      if door.entry_to?(fob) == true
        flash[:notice] = "blah blah"
       # flash.now[:success] = "Welcome to nobolab #{user.name}"
        render 'open'
      else
        flash.now[:error] = "Sorry! You are not authorized to access"
      end

     # flash.success = "Welcome to nobolab #{user.name}"
    end
  end

end
