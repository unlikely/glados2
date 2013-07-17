class DoorSecurityController < ApplicationController

  def open
    @doors  = Door.all
    @fobs   = Fob.all

    if(params.has_key?(:fob) && params.has_key?(:door))
      @door  = Door.find(params[:door][:door_id])
      @fob   = Fob.find(params[:fob][:fob_id])
      user = @fob.user
      if @door.permitting_entry_to?(@fob) == true
        flash.now[:success] = "Welcome to nobolab #{user.name}"
      else
        flash.now[:error]   = "You are not authorized for this door. Please contact an administrator."
      end
    end
  end

end
