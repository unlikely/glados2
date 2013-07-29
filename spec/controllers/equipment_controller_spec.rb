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

  describe "GET #show" do
    it "should render #show if params :id" do
      equipment = Equipment.create(make: "lbah", model: "one model")
      get :show, :id => equipment.id
      expect(response).to render_template('show')
    end

    it "should take params :id and find a :person" do
      equipment = Equipment.create(make: "amonkey", model: "wrench")
      get :show, :id => equipment.id
      assigns(:equip).should == equipment
    end

    it "renders #index if params :id not found" do
      get :show, :id => 11111111
      expect(response).to redirect_to(equipment_path)
    end

    it "flashes :error if params :id not found" do
      get :show, :id => 11113434434
      flash.now[:error].should_not be_nil
    end
  end

  describe "GET #edit" do
    it "renders #edit with params :id" do
      equip = Equipment.create(make: "monkey2", model: "a model")
      get :edit, :id => equip.id
      expect(response).to render_template("edit")
    end

    it "takes params :id" do
      equip = Equipment.create(make: "monkey3", model: "another model")
      get :edit, :id => equip.id
      assigns(:equip).should == equip
    end
  end

   describe "POST #create" do
     it "renders #show if :equipment created" do
       equip = { :make => "monkey2", :model => "model 3" }
       post :create, :equipment => equip
       expect(response).to render_template('show')
     end

     it "flashes :success if :equipment created" do
      equip = { :make => "blahlklkj", :model => "chiwhahah"}
      post :create, :equipment => equip
      flash.now[:success].should_not be_nil
     end

     it "creates new :equipment given valid params" do
       equip = { :make => "blah", :model => "driver"}
       post :create, :equipment => equip
       Equipment.all.size.should == 1
     end

     it "renders #new if :equipment not  saved"do
       equip = { :make => "", :model => "labadoodle"}
       post :create, :equipment => equip
       expect(response).to render_template('new')
     end

     it "flashes :error if :equipment not created" do
       equip = { :make => "doggy", :model => ""}
       post :create, :equipment => equip
       flash.now[:error].should_not be_nil
     end
   end

   describe "PUT #update" do
     it "remders #show if updated" do
        equipment = Equipment.create(make: "blah", model: "model")
        attr = { :make => "toyota", :model => "rav"}
        put :update,:id => equipment.id, :equipment => attr
        response.should redirect_to(equipment_path)
     end

     it "flash.now :success not nil" do
       equipment = Equipment.create(make: "blah2", model: "model2")
       attr = { :make => "toy", :model => "blah" }
       put :update, :id => equipment.id, :equipment => attr
       flash.now[:success].should_not be_nil
     end

     it "render #edit if not updated" do
       equipment = Equipment.create(make: "blah4", model: "new model")
       attr = { :make => "ota", :model => "" }
       put :update, :id =>equipment.id, :equipment => attr
       response.should render_template('edit')
     end

     it "flash.now :error not nil" do
       equipment = Equipment.create(make: "new make4", model: "a model")
       attr = { :make => "", :model => "blah" }
       put :update, :id => equipment, :equipment => attr
       flash.now[:error].should_not be_nil
     end

     it "remders #show if updated" do
        equipment = Equipment.create(make: "toyota", model: "camry")
        new_model = "new camry"
        attr = { :make => "toyota", :model => new_model}
        put :update,:id => equipment.id, :equipment => attr
        equipment.reload
        equipment.model.should == new_model
     end
   end
end
