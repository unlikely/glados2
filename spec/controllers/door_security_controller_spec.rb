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

  describe "GET with form data" do
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
      assigns(:doors).should eq([ @door ])
    end

    it "finds a :fob from params id" do
      assigns(:fobs).should eq([ @fob ])
    end

    it "renders flash[:error] if :fob not authorized for door" do

      flash.now[:error].should = "Sorry you are not authorized for the #{@door.name}, #{@user.name}"
    end

    it "renders flash[:success] if :fob authorized for door" do
      flash.now[:success].should == "Welcome to nobolab #{@user.name}"
    end
  end
end
