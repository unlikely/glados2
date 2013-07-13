class DoorSecurityController < ApplicationController

  def open
    @doors  = Door.all
    @fobs   = Fob.all

    if(params.has_key?(:fob) && params.has_key?(:doors))
      door  = Door.find(params[:door][:door_id])
      fob   = Fob.find(params[:fob][:fob_id])
      user = fob.user
      flash.notice = "blahblah"
#      if door.entry_to?(fob)
#        flash[:notice] = "blah blah"
#        flash.now[:success] = "Welcome to nobolab #{user.name}"
#        render 'open'
#      else
#        flash.now[:error] = "Sorry! You are not authorized to access #{door.name}, #{user.name}"
#      end

      flash.success = "Welcome to nobolab #{user.name}"
    end
  end

end
