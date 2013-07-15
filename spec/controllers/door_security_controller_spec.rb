require 'spec_helper'

describe DoorSecurityController do

  describe "GET populates dropdown variables" do
    it "from Door" do
      door = create(:door)
      get :open
      assigns(:doors).should eq([ door ])
    end

    it "from Fob" do
      fob = create(:fob)
      get :open
      assigns(:fobs).should eq([ fob ])
    end
  end

  describe "GET on form submit" do
    before(:each) do
      dk = create(:door_key)
      @door = dk.door
      @fob = build(:fob)
      @fob.user = dk.user
      @fob.save
      @user = @fob.user
      get :open, :fob => {:fob_id => @fob.id}, :door => {:door_id => @door.id}
    end

    it "finds a :door from params id" do
      assigns(:door).should eq( @door )
    end

    it "finds a :fob from params id" do
      assigns(:fob).should eq( @fob )
    end
# Question about adding tests for empty fobs and/or injected null fobs
# Business decision of dealing with fobs that exist without an attached user

    it "renders flash[:success] if :fob authorized for door" do
      flash.now[:success].should == "Welcome to nobolab #{@user.name}"
    end
  end

  describe "Get from form" do
    it "renders flash[:error] if :fob not authorized for door" do
      @door = create(:door)
      @fob = create(:fob)
      get :open, :fob => {:fob_id => @fob.id}, :door => {:door_id => @door.id}
      fob = create(:fob)
      flash.now[:error].should == "You are not authorized for this door. Please contact an administrator."
    end
  end

end
