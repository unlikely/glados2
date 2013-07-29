require 'spec_helper'

describe EquipmentController do
  describe "GET #index" do
    it "populates :equip" do
      equip = Equipment.create(model: "cheese", make: "goat")
      get :index
      assigns(:equip).should eq([ equip ])
    end

    it "renders the #index" do
      equip = Equipment.create(model: "dog", make: "labadoodle")
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #new" do
    it "renders #new" do
      get :new
      expect(response).to render_template("new")
    end

    it "builds :equip" do
      get :new
      assigns(:equip).id.should eq(nil)
    end
  end

  describe "POST #create" do
    it "should render #show if :equip created" do
      @equip = { :model => "vw", :make => "golf"}
      post :create, :equip => @equip
      expect(response).to render_template("show")
    end

    it "should flash :success if :equip created" do
      @equip = { :model => "poise", :model => "wings" }
      post :create, :equip => @equip
      flash.now[:success].should_not be_nil
    end

    it "should render #new if :equip creation failed" do
      @equip = { :model => "", :model => "light" }
      post :create, :equip => @equip
      expect(response).to render_template("new")
    end

    it "should flash :error if :equip not created" do
      @equip = { :model => "toyota", :model => "" }
      post :create, :equip => @equip
      flash.now[:error].should_not be_nil
    end
  end
  describe "GET #show" do
    it "should render #show if params :id" do
      @equip = Equipment.create(make: "lbah", model: "one model")
      get :show, :id => @equip.id
      expect(response).to render_template("show")
    end

    it "should take params :id and find a :person" do
      @equip = Equipment.create(make: "amonkey", model: "wrench")
      get :show, :id => @equip.id
      assigns(:equip).should == @equip
    end

    it "should render #index if params :id not found" do
      get :show, :id => 11111111
      expect(response).to render_template("index")
    end

    it "should flash :error if params :id not found" do
      get :show, :id => 11113434434
      flash.now[:error].should_not be_nil
    end
  end
end
