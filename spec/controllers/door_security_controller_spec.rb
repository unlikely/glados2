require 'spec_helper'

describe DoorSecurityController do

  describe "GET populates dropdown variables" do
    it "from Door" do
      door = Door.create(name: "doorname1")
      get :open
      assigns(:doors).should eq([ door ])
    end

    it "from Fob" do
      fob = Fob.create(key: "smelly")
      get :open
      assigns(:fobs).should eq([ fob ])
    end
  end

  describe "GET on form submit" do
    before(:each) do
      dk = DoorKey.create(person: Person.new(name: "name1"), door: Door.new(name: "doorname2"))
      @door = dk.door
      @fob = Fob.create(key: "smelly2", person: dk.person)
      @person = @fob.person
      get :open, :fob => {:id => @fob.id}, :door => {:id => @door.id}
    end

    it "finds a :door from params id" do
      assigns(:door).should eq( @door )
    end

    it "finds a :fob from params id" do
      assigns(:fob).should eq( @fob )
    end
# Question about adding tests for empty fobs and/or injected null fobs
# Business decision of dealing with fobs that exist without an attached person

    it "renders flash[:success] if :fob authorized for door" do
      flash.now[:success].should == "Welcome to nobolab #{@person.name}"
    end
  end

  describe "Get from form" do
    it "renders flash[:error] if :fob not authorized for door" do
      @door = Door.create(name: "doorname3") 
      @fob = Fob.create(key: "smelly3")
      get :open, :fob => {:id => @fob.id}, :door => {:id => @door.id}
      flash.now[:error].should == "You are not authorized for this door. Please contact an administrator."
    end
  end

end
