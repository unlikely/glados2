require 'spec_helper'

describe AgreementExecutionsController do
  describe "GET #index" do
    it "populates :agreement_executions" do
      agreement_execution = create(:agreement_execution)
      get :index
      assigns(:agreement_executions).should == [ agreement_execution ]
    end

    it "renders #index" do
      agreement_execution = create(:agreement_execution)
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "renders #show if :id is valid" do
      agreement_execution = create(:agreement_execution)
      get :show, :id => agreement_execution.id
      expect(response).to render_template("show")
    end

    it "populates :agreement_execution from valid :id" do
      agreement_execution = create(:agreement_execution)
      get :show, :id => agreement_execution.id
      assigns(:agreement_execution).should == agreement_execution
    end

    it "redirects to #index if agreement_execution not found" do
      get :show, :id => 98798798798987
      expect(response).to redirect_to(agreement_executions_path)
    end

    it "flases :error if agreement_execution not found" do
      get :show, :id => 888777888888
      flash[:error].should_not be_nil
    end
  end

  describe "GET #new" do
    it "renders #new" do
      get :new
      expect(response).to render_template("new")
    end

    it "creates empty :agreement_execution object" do
      get :new
      assigns(:agreement_execution).agreement_url.should be_nil
    end
  end

  describe "POST #create" do
    it "redirects to #index if :agreement_execution saved" do
      agreement_execution = { :agreement_url => "http://www.blah.com",
        :agreement_id => create(:agreement).id, :person_id => create(:person).id,
        :date_signed => Date.today }
      post :create, :agreement_execution => agreement_execution
      expect(response).to redirect_to(agreement_executions_path)
    end

    it "flashes :success if :agreement_execution saved" do
      agreement_execution = { :agreement_url => "http://www.blah.com",
        :agreement_id => create(:agreement).id, :person_id => create(:person).id,
        :date_signed => Date.today }
      post :create, :agreement_execution => agreement_execution
      flash[:success].should_not be_nil
    end

    it "creates new :agreement_execution" do
      agreement_execution = { :agreement_url => "http://www.blah.com",
        :agreement_id => create(:agreement).id, :person_id => create(:person).id,
        :date_signed => Date.today }
      a_count = AgreementExecution.count
      post :create, :agreement_execution => agreement_execution
      AgreementExecution.count.should == 1 + a_count
    end

    it "renders #new if :agreement_execution not saved" do
      agreement_execution = { :agreement_url => "",
        :agreement_id => create(:agreement).id, :person_id => create(:person).id,
        :date_signed => Date.today }
      post :create, :agreement_execution => agreement_execution
      expect(response).to redirect_to(new_agreement_execution_path)
    end

    it "flashes :error if :agreement_execution not saved" do
      agreement_execution = { :agreement_url => "",
        :agreement_id => create(:agreement).id, :person_id => create(:person).id,
        :date_signed => Date.today }
      post :create, :agreement_execution => agreement_execution
      flash[:error].should_not be_nil
    end
  end

  describe "GET #edit" do
    it "renders #edit if :id is correct" do
      agreement_execution = create(:agreement_execution)
      get :edit, :id => agreement_execution.id
      expect(response).to render_template("edit")
    end

    it "finds associated :agreement_execution if correct :id" do
      agreement_execution = create(:agreement_execution)
      get :edit, :id => agreement_execution.id
      assigns(:agreement_execution).should == agreement_execution
    end

    it "redirects to #index if :id not found" do
      get :edit, :id => 999888
      expect(response).to redirect_to(agreement_executions_path)
    end

    it "flashes :error if :id not found" do
      get :edit, :id => 889998
      flash[:error].should_not be_nil
    end
  end

  describe "PUT #update" do
    it "redirects to #index if :agreement_execution updated" do
      person = create(:person)
      agreement = create(:agreement)
      agreement_execution = create(:agreement_execution, :agreement => agreement, :person => person)
      agreement_execution1 = { :agreement_url => "http://www.blahblah.com", :agreement_id => agreement.id, :person_id => person.id, :date_signed => Date.today.to_s }
      put :update, :id => agreement_execution.id, :agreement_execution => agreement_execution1
      expect(response).to redirect_to(agreement_executions_path)
    end

    it "updates :agreement_execution if given proper params" do
      person = create(:person)
      agreement = create(:agreement)
      agreement_url = "http://www.onemore.com"
      agreement_execution = create(:agreement_execution, :agreement => agreement, :person => person)
      agreement_execution1 = { :agreement_url => agreement_url, :agreement_id => agreement.id, :person_id => person.id, :date_signed => Date.today.to_s }
      put :update, :id => agreement_execution.id, :agreement_execution => agreement_execution1
      agreement_execution.reload
      agreement_execution.agreement_url.should == agreement_url
    end

    it "flash :success is not nil if :agreement_execution updated" do
      person = create(:person)
      agreement = create(:agreement)
      agreement_execution = create(:agreement_execution, :agreement => agreement, :person => person)
      agreement_execution1 = { :agreement_url => "http://somethingmore.com", :agreement_id => agreement.id, :person_id => person.id, :date_signed => Date.today.to_s }
      put :update, :id => agreement_execution.id, :agreement_execution => agreement_execution1
      flash[:success].should_not be_nil
    end

    it "redirects to #edit if :agreement_execution not updated" do
      person = create(:person)
      agreement = create(:agreement)
      agreement_execution = create(:agreement_execution, :agreement => agreement, :person => person)
      agreement_execution1 = { :agreement_url => "", :agreement_id => agreement.id, :person_id => person.id, :date_signed => Date.today.to_s }
      put :update, :id => agreement_execution.id, :agreement_execution => agreement_execution1
      expect(response).to be_success
    end

    it "flash :error is not nil if :agreement_execution not updated" do
      person = create(:person)
      agreement = create(:agreement)
      agreement_execution = create(:agreement_execution, :agreement => agreement, :person => person)
      agreement_execution1 = { :agreement_url => "", :agreement_id => agreement.id, :person_id => person.id, :date_signed => Date.today.to_s }
      put :update, :id => agreement_execution.id, :agreement_execution => agreement_execution1
      flash[:error].should_not be_nil
    end

    it "responds with JSON format request and fails" do
      agreement_execution = create(:agreement_execution)
      agreement_url = ""
      agreement_execution_attributes = { :id => agreement_execution.id, :format => 'json', :agreement_execution => {
        :agreement_url => agreement_url, :person_id => agreement_execution.person.id,
        :agreement_id => agreement_execution.agreement.id,
        :date_signed => agreement_execution.date_signed
        }}
      put :update, agreement_execution_attributes
      agreement_execution.reload
      response.should_not be_success
    end

    it "responds with JSON format request and is success (200)" do
      agreement_execution = create(:agreement_execution)
      agreement_url = "http://www.somebrandnewurl.com"
      agreement_execution_attributes = { :id => agreement_execution.id, :format => 'json', :agreement_execution => {
        :agreement_url => agreement_url, :person_id => agreement_execution.person.id,
        :agreement_id => agreement_execution.agreement.id,
        :date_signed => agreement_execution.date_signed
        }}
      put :update, agreement_execution_attributes
      agreement_execution.reload
      agreement_execution.agreement_url.should == agreement_url
      response.should be_success
    end
  end

  describe "DELETE #destroy" do
    it "redirects to #index if successfully deleted" do
      agreement_execution = create(:agreement_execution)
      delete :destroy, :id => agreement_execution.id
      expect(response).to redirect_to(agreement_executions_path)
    end

    it "flash :success is not nil if :agreement_execution deleted" do
      agreement_execution = create(:agreement_execution)
      delete :destroy, :id => agreement_execution.id
      flash[:success].should_not be_nil
    end

    it "successfully deleted :agreement_execution" do
      agreement_execution = create(:agreement_execution)
      delete :destroy, :id => agreement_execution.id
      AgreementExecution.find_by_id(agreement_execution.id).should be_nil
    end

    it "redirects to referrer if :agreement_execution deletion failed" do
      request.env["HTTP_REFERER"] = "www.someurl.gov"
      delete :destroy, :id => 88888999898
      expect(response).to redirect_to("www.someurl.gov")
    end

    it "flash :error is not nil if :agreement_execution not deleted" do
      request.env["HTTP_REFERER"] = "www.someotherurl.gov"
      delete :destroy, :id => 5768584848
      flash[:error].should_not be_nil
    end
  end
end
