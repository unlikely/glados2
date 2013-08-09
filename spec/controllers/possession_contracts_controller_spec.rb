require 'spec_helper'

describe PossessionContractsController do
  describe "GET #index" do
    it "populates :possession_contracts" do
      possession_contract = PossessionContract.create(person: Person.new(name: "person1"), equipment: Equipment.new(make: "apple", model: "macbook"), contract_type: "lease", payment: 200093, expires: Date.today)
      get :index
      assigns(:possession_contracts).should == [ possession_contract ]
    end

    it "renders the #index" do
      possession_contract = PossessionContract.create(person: Person.new(name: "person2"), equipment: Equipment.new(make: "apple", model: "air"), contract_type: "sale", payment: 200093, expires: Date.today)
      get :index
      expect(response).to render_template('index')
    end
  end

  describe "GET #show" do
    it "should render #show if valid params :id" do
      possession_contract = PossessionContract.create(person: Person.new(name: "person3"), equipment: Equipment.new(make: "microsoft", model: "surface"), contract_type: "sale", payment: 2000, expires: Date.today)
      get :show, :id => possession_contract.id
      expect(response).to render_template('show')
    end

    it "should take params :id and find a :possession_contract if valid person" do
      possession_contract = PossessionContract.create(person: Person.new(name: "person4"), equipment: Equipment.new(make: "microsoft2", model: "blahsurface"), contract_type: "lease", payment: 2093, expires: Date.today)
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
    it "renders #show :possession_contract successfully created" do
      person = Person.create(name: "jon doe")
      equipment = Equipment.create(make: "dewalt", model: "driver")
      possession = { :contract_type => "lease", :payment => "500", :expires => "11/06/2014", :person_id => person.id, :equipment_id => equipment.id }
      post :create, :possession_contract => possession
      expect(response).to render_template('show')
    end

    it "flashes :success if :possession_contract created" do
      person = Person.create(name: "jane doe")
      equipment = Equipment.create(make: "norelco", model: "impact hammer")
      possession = { :contract_type => "sale", :person_id => person.id.to_s, :equipment_id => equipment.id.to_s }
      post :create, :possession_contract => possession
      flash.now[:success].should_not be_nil
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
      possession_contract = possessioncontract.create(person: person.new(name: "person6"), equipment: Equipment.new(make: "monkey", model: "do"), contract_type: "borrow", payment: 88, expires: date.today)
      get :edit, :id => possession_contract.id.to_s
      expect(response).to render_template('edit')
    end

    it "takes an :id params and find associated possession_contract" do
      possession_contract = possessioncontract.create(person: person.new(name: "person7"), equipment: Equipment.new(make: "dog", model: "retriever"), contract_type: "sale", payment: 788, expires: date.today)
      get :edit, :id  => possession_contract.id.to_s
      assigns(:possession_contract).should == possession_contract
    end
  end

  describe "PUT #update" do
    it "renders #show if :possessession_contract updated" do
      person = Person.new(name: "a new name")
      equipment = Equipment.new(make: "lowes", model: "belter"),
      possession_contract = possessioncontract.create(person: person, equipment:  equipment, contract_type: "lease", payment: 780, expires: date.today)
      attr = { :expires => Date.today.to_s, :contract_type => "lease", :payment => 100, :person => person.id, :equipment => equipment.id }
      put :update, :id => possession_contract.id, :possession_contract => attr
      expect(response).to render_template('show')
    end

    it "updates :possession_contract if given proper params" do
      person = Person.new(name: "another name")
      equipment = Equipment.new(make: "make44", model: "model69"),
      possession_contract = possessioncontract.create(person: person, equipment:  equipment, contract_type: "lease", payment: 780, expires: date.today)
      attr = { :expires => Date.today.to_s, :contract_type => "buy", :payment => 20, :person => person.id, :equipment => equipment.id }
      put :update, :id => possession_contract.id, :possession_contract => attr
    end

    it "flash.now :success is not nil if :possession_contract is updated" do
      person = Person.new(name: "a new name4")
      equipment = Equipment.new(make: "hd", model: "ladder"),
      possession_contract = possessioncontract.create(person: person, equipment:  equipment, contract_type: "lease", payment: 9978665, expires: date.today)
      attr = { :expires => Date.today.to_s, :contract_type => "lease", :payment => 1000, :person => person.id, :equipment => equipment.id }
      put :update, :id => possession_contract.id, :possession_contract => attr
      flash.now[:success].should_not be_nil
    end

    it "renders #edit if :possession_contract is not updated" do
      person = Person.new(name: "a new name5")
      equipment = Equipment.new(make: "new make", model: "new model"),
      possession_contract = possessioncontract.create(person: person, equipment:  equipment, contract_type: "lease", payment: 4677, expires: date.today)
      attr = { :expires => Date.today.to_s, :contract_type => "", :payment => 998, :person => person.id, :equipment => equipment.id }
      put :update, :id => possession_contract.id, :possession_contract => attr
      expect(response).to render_template('edit')
    end

    it "flashes :error if :possession_contract is not udpated" do
      person = Person.new(name: "a new name7")
      equipment =  Equipment.new(make: "new make3", model: "new model4"),
      possession_contract = possessioncontract.create(person: person, equipment:  equipment, contract_type: "buy", payment: 657, expires: date.today)
      attr = { :expires => Date.today.to_s, :contract_type => "", :payment => 8887, :person => person.id, :equipment => equipment.id }
      put :update, :id => possession_contract.id, :possession_contract => attr
      flash.now[:error].should_not be_nil
    end

     it "flashes :error if :id not found" do
      person = Person.create(name: "another name")
      equipment = Equipment.create(make: "another make", model: "another model")
      attr = { :expires => Date.today.to_s, :contract_type => "", :payment => 8887, :person => person.id, :equipment => equipment.id }
      put :update, :id => 667788888, :possession_contract => attr
      flash.now[:error].should_not be_nil
     end
  end

  describe "DELETE #destroy" do
    it "renders #index if successfully deleted" do
      possession_contract = PossessionContract.create(person: Person.new(name: "YAN3"), equipment: Equipment.new(make: "another make", model: "another model"), contract_type: "lease", payment: 666, expires: Date.today)
      delete :destroy, :id => possession_contract.id
      expect(response).to redirect_to(possession_contracts_path)
    end

    it "successfully deleted possession_contract for that id" do
      possession_contract = PossessionContract.create(person: Person.new(name: "YAN2"), equipment: Equipment.new(make: "chicita", model: "banana"), contract_type: "lease", payment: 4995, expires: Date.today)
      delete :destroy, :id => possession_contract.id
      PossessionContract.find_by_id(possession_contract.id).should be_nil
    end

    it "flashes :success when deleted" do
      possession_contract = PossessionContract.create(person: Person.new(name: "yet another"), equipment: Equipment.new(make: "orange", model: "air"), contract_type: "buy", payment: 45, expires: Date.today)
      delete :destroy, :id => possession_contract.id
      flash.now[:success].should_not be_nil
    end

    it "should render #index if :id not found or failed to delete" do
      delete :destroy, :id => 8797865875687
      expect(response).to render_template('index')
    end

    it "flashes :error if failed to delete" do
      delete :destroy, :id => 9927687638268
      flash.now[:error].should_not be_nil
    end
  end
end
