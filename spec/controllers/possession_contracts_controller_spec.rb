require 'spec_helper'

describe PossessionContractsController do
  describe "GET #index" do
    it "populates :possession_contracts" do
      possession_contract = create(:possession_contract_with_lease)
      get :index
      assigns(:possession_contracts).should == [ possession_contract ]
    end

    it "renders the #index" do
      possession_contract = PossessionContract.create(person: Person.new(name: "person2"),
                              equipment: Equipment.create(make: "apple", model: "air"),
                              contract_type: "a sale", payment: 200093, expires: Date.today)
      get :index
      expect(response).to render_template('index')
    end
  end

  describe "GET #show" do
    it "should render #show if valid params :id" do
      possession_contract = PossessionContract.create(person: Person.new(name: "person3"),
                               equipment: Equipment.create(make: "microsoft", model: "surface"),
                               contract_type: "a sale", payment: 2000, expires: Date.today)
      get :show, :id => possession_contract.id
      expect(response).to render_template('show')
    end

    it "should take params :id and find a :possession_contract if valid person" do
      possession_contract = create(:possession_contract_with_lease)
      get :show, :id => possession_contract.id
      assigns(:possession_contract).should == possession_contract
    end

    it "renders #index if params :id not valid or not found" do
      get :show, :id => 9999999999
      expect(response).to redirect_to(possession_contracts_path)
    end

    it "flashes :error if params :id not valid or not found" do
      get :show, :id => 88778766666
      flash.now[:error].should_not be_nil
    end
  end

  describe "GET #new" do
    it "renders #new" do
      get :new
      expect(response).to render_template('new')
    end

    it "build :possession_contract object" do
      get :new
      assigns(:possession_contract).id.should == nil
    end
  end

  describe "POST #create" do
    it "redirect_to #index :possession_contract successfully created" do
      possession_contract = build(:possession_contract_with_lease)
      possession_contract_attr = possession_contract.attributes.except("updated_at", "created_at")
      post :create, :possession_contract => possession_contract_attr
      expect(response).to redirect_to(possession_contracts_path)
    end

    it "flashes :success if :possession_contract created" do
      person = Person.create(name: "jane doe")
      equipment = Equipment.create(make: "norelco", model: "impact hammer")
      possession = { :contract_type => "a sale", :person_id => person.id.to_s, :equipment_id => equipment.id.to_s }
      post :create, :possession_contract => possession
      flash[:success].should_not be_nil
    end

    it "creates new :possession_contract provided valid params" do
      mycount = Equipment.count
      person = Person.create(name: "Jose Cristo")
      equipment = Equipment.create(make: "new make", model: "run out of models")
      possession = { :contract_type => "borrow", :person_id => person.id.to_s, :equipment_id => equipment.id.to_s }
      post :create, :possession_contract => possession
      PossessionContract.count.should == 1 +mycount
    end

    it "renders #new if :possession_contract is not saved" do
      person = Person.create(name: "name one milion")
      equipment = Equipment.create(make: "new make2", model: "run out of models2")
      possession = { :contract_type => "", :person_id => person.id.to_s, :equipment_id => equipment.id.to_s }
      post :create, :possession_contract => possession
      expect(response).to render_template('new')
    end

    it "flashes :error if :possession_contract not created" do
      person = Person.create(name: "name one milion3")
      equipment = Equipment.create(make: "new make3", model: "run out of models3")
      possession = { :contract_type => "", :person_id => person.id.to_s, :equipment_id => equipment.id.to_s }
      post :create, :possession_contract => possession
      flash.now[:error].should_not be_nil
    end
  end

  describe "GET #edit" do
    it "renders #edit if params :id is correct" do
      possession_contract = PossessionContract.create(
        person: Person.new(name: "person6"),
        equipment: Equipment.create(make: "monkey", model: "do"),
        contract_type: "borrow", payment: 88, expires: Date.today)
      get :edit, :id => possession_contract.id
      expect(response).to render_template('edit')
    end

    it "takes an :id params and find associated possession_contract" do
      possession_contract = PossessionContract.create(
        person: Person.new(name: "person7"),
        equipment: Equipment.create(make: "dog", model: "retriever"),
        contract_type: "a sale", payment: 788, expires: Date.today)
      get :edit, :id  => possession_contract.id.to_s
      assigns(:possession_contract).should == possession_contract
    end

    it "redirects to #index if :id not found" do
      get :edit, :id => 9999999999
      expect(response).to redirect_to(possession_contracts_path)
    end

    it "flashes an error if :id not found" do
      get :edit, :id => 88888888888888
      flash[:error].should_not be_nil
    end
  end

  describe "PUT #update" do
    it "redirects to #index if :possessession_contract updated" do
      possession_contract = create(:possession_contract_with_lease)
      possession_contract_attr = possession_contract.attributes.except("updated_at", "created_at")
      put :update, :id => possession_contract.id, :possession_contract => possession_contract_attr
      expect(response).to redirect_to(possession_contracts_path)
    end

    it "updates :possession_contract if given proper params" do
      person = Person.new(name: "another name")
      equipment = Equipment.create(make: "make44", model: "model69")
      contract_type = "a sale"
      possession_contract = PossessionContract.create(person: person, equipment:  equipment,
                             contract_type: "borrow", payment: 780, expires: Date.today)
      attr = { :expires => Date.today.to_s, :contract_type => contract_type, :payment => 20, :person_id => person.id, :equipment_id => equipment.id }
      put :update, :id => possession_contract.id, :possession_contract => attr
      possession_contract.reload
      possession_contract.contract_type.should == contract_type
    end

    it "flashes :success is not nil if :possession_contract is updated" do
      possession_contract = create(:possession_contract_with_lease)
      possession_contract_attr = possession_contract.attributes.except("updated_at", "created_at")
      put :update, :id => possession_contract.id, :possession_contract => possession_contract_attr
      flash[:success].should_not be_nil
    end

    it "renders to #edit if :possession_contract is not updated" do
      possession_contract = create(:possession_contract_with_lease)
      possession_contract_attr = possession_contract.attributes.except("updated_at", "created_at")
      possession_contract_attr = { :payment => "" }
      put :update, :id => possession_contract.id, :possession_contract => possession_contract_attr
      expect(response).to render_template('edit')
    end

    it "flashes :error if :possession_contract is not udpated" do
      person = Person.new(name: "a new name7")
      equipment =  Equipment.create(make: "new make3", model: "new model4")
      possession_contract = PossessionContract.create(person: person, equipment: equipment,
                               contract_type: "a sale", payment: 657, expires: Date.today)
      attr = { :expires => Date.today.to_s, :contract_type => "", :payment => 8887, :person_id => person.id, :equipment_id => equipment.id }
      put :update, :id => possession_contract.id, :possession_contract => attr
      flash.now[:error].should_not be_nil
    end
  end

  describe "DELETE #destroy" do
    it "redirects to #index if successfully deleted" do
      possession_contract = create(:possession_contract_with_lease)
      delete :destroy, :id => possession_contract.id
      expect(response).to redirect_to(possession_contracts_path)
    end

    it "successfully deleted possession_contract for that id" do
      possession_contract = create(:possession_contract_with_lease)
      delete :destroy, :id => possession_contract.id
      PossessionContract.find_by_id(possession_contract.id).should be_nil
    end

    it "flashes :success when deleted" do
      possession_contract = PossessionContract.create(
        person: Person.new(name: "yet another"),
        equipment: Equipment.create(make: "orange", model: "air"), contract_type: "a sale",
        payment: 45, expires: Date.today)
      delete :destroy, :id => possession_contract.id
      flash[:success].should_not be_nil
    end

    it "should redirect back to Referrer if :id not found or failed to delete" do
      request.env["HTTP_REFERER"] = "www.blah.com"
      delete :destroy, :id => 8797865875687
      expect(response).to redirect_to("www.blah.com")
    end

    it "flashes :error if failed to delete" do
      request.env["HTTP_REFERER"] = possession_contracts_path
      delete :destroy, :id => 9927687638268
      flash[:error].should_not be_nil
    end
  end
end
