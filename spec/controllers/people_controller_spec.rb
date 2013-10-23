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
      assigns(:person).new_record?.should be_true
    end
  end

  describe "POST #create" do
    it "flashes :success if :person created" do
      person = {:name => "tarti"}
      post :create, :person => person
      flash[:success].should_not be_nil
    end

    it "redirect to #show if :person created" do
      person = {:name => "nutella"}
      post :create, :person => person
      expect(response).to redirect_to(people_path)
    end

    it "redirects to #new if missing information" do
      person = {:name => ""}
      post :create, :person => person
      expect(response).to redirect_to(new_person_path)
    end

    it "flashes :error if :person not created" do
      person = {:name => ""}
      post :create, :person => person
      flash[:error].should_not be_nil
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

    it "redirect #index if params :id not found" do
      get :show, :id => 2323232233
      expect(response).to redirect_to(people_path)
    end

    it "flashes :error if person not found" do
      get :show, :id => 9899898
      flash[:error].should_not be_nil
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

    it "redirect to #index if params :id not found" do
      get :show, :id => 232390808908
      expect(response).to redirect_to(people_path)
    end

    it "flash :error if person not found" do
      get :show, :id => 989989888887
      flash[:error].should_not be_nil
    end
  end

  describe "PUT #update" do
    it "redirect to #index if :person udpated" do
      person = Person.create(name: "one more name")
      attr   = { :name => "new name2" }
      put :update, :id => person.id, :person => attr
      response.should redirect_to(people_path)
    end

    it "flash :success if :person updated" do
      person = Person.create(name: "one more name2")
      attr   = { :name => "new name" }
      put :update, :id => person.id, :person => attr
      flash[:success].should_not be_nil
    end

    it ":person name is updated" do
      person = Person.create(name: "another p")
      name = "pppppp"
      attr = { :name => name }
      put :update, :id => person.id, :person => attr
      person.reload
      person.name.should == name
    end

    it "redirects to #edit if failed :person update" do
      person = Person.create(name: "second name")
      invalid_attr = { :name => "" }
      put :update, :id => person.id, :person => invalid_attr
      response.should redirect_to(edit_person_path)
    end

    it "flashes :error if :person update failed" do
      person = Person.create(name: "second name22")
      invalid_attr = { :name => "" }
      put :update, :id => person.id, :person => invalid_attr
      flash[:error].should_not be_nil
    end
  end

  describe "DELETE #destroy" do
    it "flashes :success when deleted" do
      person = Person.create(name: "third")
      delete :destroy, :id=> person.id
      flash[:success].should_not be_nil
    end

    it "redirects to #index once :person deleted" do
      person = Person.create(name: "fourth")
      delete :destroy, :id => person.id
      response.should redirect_to(people_path)
    end

    it "renders #index if :person not found" do
      delete :destroy, :id => 77777777777888888
      expect(response).to redirect_to(people_path)
    end

    it "flashes :error if failed to delete" do
      delete :destroy, :id => 999889009878888
      flash[:error].should_not be_nil
    end

    it "successfully deleted :person" do
      person = Person.create(name: "malakalai")
      delete :destroy, :id=> person.id
      Person.find_by_id(person.id).should be_nil
    end
  end

  describe "GET #show_equipment_possession_on_date" do
    it "renders show_equipment_possession when successful" do
      person = Person.create(name: "a new name")
      equipment = Equipment.create(make: "vw", model: "golf")
      possession_contract = PossessionContract.create(person: person, equipment: equipment, contract_type: "borrow", expires: Date.today)
      get :show_equipment_possession_on_date, :id => person.id
      expect(response).to render_template('show_equipment_possession')
    end

    it "assigns :possession_contracts if correct params[:id] passed"do
      person = Person.new(name: "person 34")
      equipment = Equipment.create(make: "vw", model: "jetta")
      equipment2 = Equipment.create(make: "dewalt", model: "impact drill")
      expires = Date.today
      possession_contract = PossessionContract.create(person: person, equipment: equipment, contract_type: "a donation", expires: expires + 10.days)
      possession_contract2 = PossessionContract.create(person: person, equipment: equipment2, contract_type: "a donation", expires: expires - 10.days)
      get :show_equipment_possession_on_date, :id => person.id
      assigns(:possession_contracts).should == [ possession_contract ]
    end

    it "assigns :possession_contracts with correct contracts passed"do
      person = Person.new(name: "person 35")
      person2 = Person.new(name: "person 36")
      equipment = Equipment.create(make: "husky", model: "tape measure")
      equipment2 = Equipment.create(make: "husky", model: "tool box")
      expires = Date.today
      possession_contract = PossessionContract.create(person: person, equipment: equipment, contract_type: "borrow", expires: expires + 10.days)
      possession_contract2 = PossessionContract.create(person: person2, equipment: equipment2, contract_type: "borrow", expires: expires + 10.days)
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
      flash[:error].should_not be_nil
    end

    it "redirects to #index if :person not found or invalid" do
      get :show_equipment_possession_on_date, :id => 98797978979797
      expect(response).to render_template('index_equipment_possession_on_date')
    end

    it "flashes :error if no possession_contracts found" do
      get :show_equipment_possession_on_date, :id => 111111111111
      flash[:error].should_not be_nil
    end

    it "assigns :date todays date when no date provided" do
      person = Person.create(name: "lohan")
      get :show_equipment_possession_on_date, :id => person.id
      assigns(:date).should == Date.today
    end

    it "assigns :date when correct date params" do
      date = Date.new(2000,5,5)
      person = Person.create(name: "adium")
      get :show_equipment_possession_on_date, :id => person.id, :date => "5/5/2000"
      assigns(:date).should == date
    end

    it "redirect to #show_equipment_possession_on_date if date incorrect" do
      person = Person.create(name: "husky")
      date = '2003/27'
      get :show_equipment_possession_on_date, :id => person.id, :date => date
      expect(response).to redirect_to(show_person_equipment_path(person.id))
    end

    it "flashes :error if date params incorrect format" do
      person = Person.create(name: "mr clean")
      date = '24444/09'
      get :show_equipment_possession_on_date, :id => person.id, :date => date
      flash[:error].should_not be_nil
    end
  end

  describe "GET #index_equipment_possession_on_date" do
    it "renders index_equipment_possession when successful" do
      person = Person.new(name: "firstname")
      equipment = Equipment.new(model: "model1", make: "make1")
      possession_contract = PossessionContract.create(person: person, equipment: equipment, contract_type: "a lease")
      get :index_equipment_possession_on_date
      expect(response).to render_template('index_equipment_possession_on_date')
    end

    it "assigns :people with correct contracts on default date" do
       possession_contract = create(:possession_contract)
       possession_contract2 = create(:possession_contract)
       possession_contract3 = create(:possession_contract)
       get :index_equipment_possession_on_date
       assigns(:people).should == [ person3 , person]
    end

    it "flashes :error if no :people found" do
       get :index_equipment_possession_on_date
       flash.now[:error].should_not be_nil
    end

    it "renders #index_equipment_possession_on_date when no possession_contracts returned" do
      get :index_equipment_possession_on_date
      expect(response).to render_template("index_equipment_possession_on_date")
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
      expect(response).to redirect_to(people_equipment_path)
    end

    it "flashes :error if date params incorrect format" do
      date = '2013/5'
      get :index_equipment_possession_on_date, :date => date
      flash[:error].should_not be_nil
    end
  end
end
