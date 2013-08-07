require 'spec_helper'

describe PeopleController do
  describe "GET #index" do
    it "populates people variable" do
      person = Person.create(name: "tarti")
      get :index
      assigns(:people).should eq([ person ])
    end

    it "renders the #index" do
      get :index
      response.should be_successful
    end
  end

  describe "GET #new" do
    it "renders #new" do
      get :new
      response.should be_successful
    end

    it "builds new person" do
      get :new
      assigns(:person).id.should eq(nil)
    end
  end

  describe "POST #create" do
    it "flashes :success if :person created" do
      person = {:name => "tarti"}
      post :create, :person => person
      flash.now[:success].should_not be_nil
    end

    it "renders #show if :person created" do
      person = {:name => "nutella"}
      post :create, :person => person
      expect(response).to render_template("show")
    end

    it "renderes #new if missing information" do
      person = {:name => ""}
      post :create, :person => person
      expect(response).to render_template("new")
    end

    it "flashes :error if :person not created" do
      person = {:name => ""}
      post :create, :person => person
      flash.now[:error].should_not be_nil
    end

    it "creates new :person given valid params" do
      mycount = Person.count
      person = { :name => "terti"}
      post :create, :person => person
      Person.count.should == 1 + mycount
    end
  end

  describe "GET #Show" do
    it "takes params :id and find a :person" do
      person = Person.create(name: "a person")
      get :show, :id => person.id
      assigns(:person).should == person
    end

    it "takes :id and render #show" do
      person = Person.create(name: "yet another person")
      get :show, :id => person.id
      expect(response).to render_template("show")
     end

    it "render #index if params :id not found" do
      get :show, :id => 2323232233
      expect(response).to render_template("index")
    end

    it "flashes :error if person not found" do
      get :show, :id => 9899898
      flash.now[:error].should_not be_nil
    end
  end

  describe "GET #Edit" do
    it "takes :id and render #edit" do
      person = Person.create(name: "a name2")
      get :edit, :id => person.id
      expect(response).to render_template("edit")
    end

    it "takes params :id and find :person" do
      person = Person.create(name: "a name2")
      get :edit, :id => person.id
      assigns(:person).should == person
    end

    it "render #index if params :id not found" do
      get :show, :id => 232390808908
      expect(response).to render_template("index")
    end

    it "flash :error if person not found" do
      get :show, :id => 989989888887
      flash.now[:error].should_not be_nil
    end
  end

  describe "PUT #update" do
    it "redirect to #show if :person udpated" do
      person = Person.create(name: "one more name")
      attr   = { :name => "new name2" }
      put :update, :id => person.id, :person => attr
      response.should redirect_to(person_path(person))
    end

    it "flash :success if :person updated" do
      person = Person.create(name: "one more name2")
      attr   = { :name => "new name" }
      put :update, :id => person.id, :person => attr
      flash.now[:success].should_not be_nil
    end

    it "renders #show if :person updated" do
      person = Person.create(name: "another p")
      name = "pppppp"
      attr = { :name => name }
      put :update, :id => person.id, :person => attr
      person.reload
      person.name.should == name
    end

    it "renders #edit if failed :person update" do
      person = Person.create(name: "second name")
      invalid_attr = { :name => "" }
      put :update, :id => person.id, :person => invalid_attr
      response.should render_template('edit')
    end

    it "renders #index if :id does not exist" do
      attr   = { :name => "new name" }
      put :update, :id => 8899999009, :person => attr
      flash.now[:error].should_not be_nil
    end

    it "flashes :error if :person update failed" do
      person = Person.create(name: "second name22")
      invalid_attr = { :name => "" }
      put :update, :id => person.id, :person => invalid_attr
      flash.now[:error].should_not be_nil
    end
  end

  describe "DELETE #destroy" do
    it "finds :person from params :id" do
      person = Person.create(name: "third")
      delete :destroy, :id=> person.id
      flash.now[:success].should_not be_nil
    end

    it "redirects to #index once :person deleted" do
      person = Person.create(name: "fourth")
      delete :destroy, :id => person.id
      response.should redirect_to(people_path)
    end

    it "renders #index if :person not found" do
      delete :destroy, :id => 77777777777888888
      expect(response).to render_template('index')
    end

    it "flashes :error if :person not found" do
      delete :destroy, :id => 999889009878888
      flash.now[:error].should_not be_nil    end
    it "can't find :person if deleted" do:w

      person = Person.create(name: "malakalai")
      delete :destroy, :id=> person.id
      Person.find_by_id(person.id).should be_nil
    end
  end

  describe "GET #show_equipment_possession_on_date" do
    it "renders show_equipment_possession when successful" do
      person = Person.new(name: "a new name")
      equipment = Equipment.new(make: "vw", model: "golf")
      possession_contract = PossessionContract.create(person: person, equipment: equipment, contract_type: "lease", expires: Date.today)
      get :show_equipment_possession_on_date, :id => person.id
      expect(response).to render_template('show_equipment_possession')
    end

    it "assigns :possession_contracts if correct params[:id] passed"do
      person = Person.new(name: "person 34")
      equipment = Equipment.new(make: "vw", model: "jetta")
      equipment2 = Equipment.new(make: "dewalt", model: "impact drill")
      expires = Date.today
      possession_contract = PossessionContract.create(person: person, equipment: equipment, contract_type: "lease", expires: expires + 10.days)
      possession_contract2 = PossessionContract.create(person: person, equipment: equipment2, contract_type: "lease", expires: expires - 10.days)
      get :show_equipment_possession_on_date, :id => person.id
      assigns(:possession_contracts).should == [ possession_contract ]
    end

    it "assigns :possession_contracts with correct contracts passed"do
      person = Person.new(name: "person 35")
      person2 = Person.new(name: "person 36")
      equipment = Equipment.new(make: "husky", model: "tape measure")
      equipment2 = Equipment.new(make: "husky", model: "tool box")
      expires = Date.today
      possession_contract = PossessionContract.create(person: person, equipment: equipment, contract_type: "lease", expires: expires + 10.days)
      possession_contract2 = PossessionContract.create(person: person2, equipment: equipment2, contract_type: "lease", expires: expires + 10.days)
      get :show_equipment_possession_on_date, :id => person.id
      assigns(:possession_contracts).should_not == [ possession_contract2 ]
    end

    it "assigns :person if correct params[:id] passed" do
      person = Person.create(name: "matrix")
      get :show_equipment_possession_on_date, :id => person.id
      assigns(:person).should == person
    end

    it "flashes :error if :person not found or invalid" do
      get :show_equipment_possession_on_date, :id => 100000000000
      flash.now[:error].should_not be_nil
    end

    it "flashes :error if no possession_contracts found" do
      get :show_equipment_possession_on_date, :id => 111111111111
      flash.now[:error].should_not be_nil
    end

    it "assigns :date todays date when no date in query string" do
      person = Person.create(name: "lohan")
      get :show_equipment_possession_on_date, :id => person.id
      assigns(:date).should == Date.today
    end

    it "assigns :date when correctly formatted date params" do
      date = Date.new(2000,5,5)
      person = Person.create(name: "adium")
      get :show_equipment_possession_on_date, :id => person.id, :date => "5/5/2000"
      assigns(:date).should == date
    end

    it "renders error template if date params incorrect format" do
      person = Person.create(name: "husky")
      date = '2003/27'
      get :show_equipment_possession_on_date, :id => person.id, :date => date
      expect(response).to render_template('error')
    end

    it "flashes :error if date params incorrect format" do
      person = Person.create(name: "mr clean")
      date = '24444/09'
      get :show_equipment_possession_on_date, :id => person.id, :date => date
      flash.now[:error].should_not be_nil
    end
  end

  describe "GET #index_equipment_possession_on_date" do
    it "renders index_equipment_possession when successful" do
      person = Person.new(name: "firstname")
      equipment = Equipment.new(model: "model1", make: "make1")
      possession_contract = PossessionContract.create(person: person, equipment: equipment, contract_type: "lease")
      get :index_equipment_possession_on_date
      expect(response).to render_template('index_equipment_possession')
    end

    it "assigns :possession_contracts with correct contracts with default date" do
       person     = Person.create(name: "firstnames3")
       person2    = Person.create(name: "namer3")
       equipment  = Equipment.new(model: "model3", make: "make3")
       equipment2  = Equipment.new(model: "mode4", make: "makes4")
       expires = Date.today
       possession_contract = PossessionContract.create(person: person, equipment: equipment, contract_type: "lease", expires: (expires + 10.days))
       possession_contract2 = PossessionContract.create(person: person, equipment: equipment2, contract_type: "lease", expires: (expires - 10.days))
       get :index_equipment_possession_on_date
       assigns(:possession_contracts).should == [ possession_contract ]
    end

    it "flashes :error if no possession_contracts returned" do
       get :index_equipment_possession_on_date
       flash.now[:error].should_not be_nil
    end

    it "assigns :date todays date when no params date" do
      get :index_equipment_possession_on_date
      assigns(:date).should == Date.today
    end

    it "assigns :date when correctly formated date params" do
      date = Date.new(2013,3,24)
      get :index_equipment_possession_on_date, :date => '3/24/2013'
      assigns(:date).should == date
    end

    it "renders error template if date params incorrect format" do
      date = '2013/5'
      get :index_equipment_possession_on_date, :date => date
      expect(response).to render_template('error')
    end

    it "flashes :error if date params incorrect format" do
      date = '2013/5'
      get :index_equipment_possession_on_date, :date => date
      flash.now[:error].should_not be_nil
    end
  end
end
