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

    it "if :equips passed in then don't create Equipment.new" do
      equip_params = {:make => "a make", :model => "a model"}
      get :new, :equip => equip_params
      assigns(:equip).make.should eq("a make")
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

    it "renders #index if params :id invalid or not found" do
      get :show, :id => 11111111
      expect(response).to redirect_to(equipment_path)
    end

    it "flashes :error if params :id invalid or not found" do
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

    it "renders #index if :equipment not found" do
      get :edit, :id => 897987989798
      expect(response).to redirect_to(equipment_path)
    end

    it "flashes :error if :equipment not found" do
      get :edit, :id => 889976666666
      flash.now[:error].should_not be_nil
    end
  end

   describe "POST #create" do
     it "renders #show if :equipment created" do
       equip = { :make => "monkey2", :model => "model 3" }
       post :create, :equipment => equip
       expect(response).to redirect_to(equipment_index_path)
     end

     it "flashes :success if :equipment created" do
      equip = { :make => "blahlklkj", :model => "chiwhahah"}
      post :create, :equipment => equip
      flash[:success].should_not be_nil
     end

     it "creates new :equipment given valid params" do
       mycount = Equipment.count
       equip = { :make => "blah", :model => "driver"}
       post :create, :equipment => equip
       Equipment.count.should == 1+mycount
     end

     it "redirects to #new if :equipment not  saved" do
       equip = { :make => "", :model => "labadoodle"}
       post :create, :equipment => equip
       expect(response).to redirect_to(new_equipment_path)
     end

     it "flashes :error if :equipment not created" do
       equip = { :make => "doggy", :model => ""}
       post :create, :equipment => equip
       flash[:error].should_not be_nil
     end
   end

   describe "PUT #update" do
     it "updates :equipment given proper params" do
        equipment = Equipment.create(make: "toyota", model: "camry")
        new_model = "new camry"
        attr = { :make => "toyota", :model => new_model}
        put :update, :id => equipment.id, :equipment => attr
        equipment.reload
        equipment.model.should == new_model
     end

     it "redirect_to #index if updated equipment" do
        equipment = Equipment.create(make: "blah", model: "model")
        attr = { :make => "toyota", :model => "rav"}
        put :update,:id => equipment.id, :equipment => attr
        response.should redirect_to(equipment_index_path)
     end

     it "flash :success not nil if updated equipment" do
       equipment = Equipment.create(make: "blah2", model: "model2")
       attr = { :make => "toy", :model => "blah" }
       put :update, :id => equipment.id, :equipment => attr
       flash[:success].should_not be_nil
     end

     it "redirect_to #edit if equipment not updated" do
       equipment = Equipment.create(make: "blah4", model: "new model")
       attr = { :make => "ota", :model => "" }
       put :update, :id =>equipment.id, :equipment => attr
       response.should redirect_to(edit_equipment_path(equipment))
     end

     it "flash.now :error not nil if equipment not updated" do
       equipment = Equipment.create(make: "new make4", model: "a model")
       attr = { :make => "", :model => "blah" }
       put :update, :id => equipment, :equipment => attr
       flash.now[:error].should_not be_nil
     end

   end

   describe "DELETE #destroy" do
     it "renders #index if successfully deleted" do
       equipment = Equipment.create(make: "vw", model: "tijuana")
       delete :destroy, :id => equipment.id
       expect(response).to redirect_to(equipment_index_path)
     end

     it "can't find :equipment if deleted" do
       equipment = Equipment.create(make: 'vw', model: 'tuareg')
       delete :destroy, :id => equipment.id
       Equipment.find_by_id(equipment.id).should be_nil
     end

     it "should flash :success when deleted" do
        equipment = Equipment.create(make: "toyota", model: "4door")
        delete :destroy, :id => equipment.id
        flash[:success].should_not be_nil
     end

     it "should render back to referrer if the delete failed" do
       request.env["HTTP_REFERER"] = "www.blah.com"
       delete :destroy, :id => 99999999999999
       expect(response).to redirect_to("www.blah.com")
     end

     it "should flash :error if failed to delete" do
       request.env["HTTP_REFERER"] = "www.blah.com"
       delete :destroy, :id => 999999999999
       flash.now[:error].should_not be_nil
     end
   end

end
