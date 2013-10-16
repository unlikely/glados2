require 'spec_helper'

describe AgreementsController do
  describe "GET #index" do
    it "populates :agreements" do
      agreement = create(:agreement)
      get :index
      assigns(:agreement).should == [ agreement ]
    end

    it "renders #index" do
      agreement = build(:agreement)
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "renders #show if :id is valid" do
      agreement = create(:agreement)
      get :show, :id => agreement.id
      expect(response).to render_template("show")
    end

    it "populates :agreement from valid :id" do
      agreement = create(:agreement)
      get :show, :id => agreement.id
      assigns(:agreement).should == agreement
    end

    it "redirects to #index if agreement not found" do
      get :show, :id => "88888999999"
      expect(response).to redirect_to(agreements_path)
    end

    it "flases :error if agreement not found" do
      get :show, :id => "999333332"
      flash[:error].should_not be_nil
    end
  end

  describe "GET #new" do
    it "renders #new" do
      get :new
      expect(response).to render_template("new")
    end

    it "creates empty :agreement object" do
      get :new
      assigns(:agreement).id.should be_nil
    end
  end

  describe "POST #create" do
    it "redirects to #index if :agreement saved" do
      agreement = { :author => "Counsel", :version => "1", :name => "liability" }
      post :create, :agreement => agreement
      expect(response).to redirect_to(agreements_path)
    end

    it "flashes :success if :agreement saved" do
      agreement = { :author => "Counsel", :version => "2", :name => "equipment" }
      post :create, :agreement => agreement
      flash[:success].should_not be_nil
    end

    it "creates new :agreement" do
      mycount = Agreement.count
      agreement = { :author => "Counsel", :version => "2", :name => "blah" }
      post :create, :agreement => agreement
      Agreement.count.should == 1 + mycount
    end

    it "renders to #new if :agreement not saved" do
      agreement = { :author => "Counsel", :version => "3", :name => "" }
      post :create, :agreement => agreement
      expect(response).to render_template('new')
    end

    it "flashes :error if :agreement not saved" do
      agreement = { :author => "Counsel", :version => "3", :name => "" }
      post :create, :agreement => agreement
      flash.now[:error].should_not be_nil
    end
  end

  describe "GET #edit" do
    it "renders #edit if :id is correct" do
     agreement = create(:agreement)
     get :edit, :id => agreement.id
     expect(response).to render_template("edit")
    end

    it "finds associated :agreement if correct :id" do
      agreement = create(:agreement)
      get :edit, :id => agreement.id
      assigns(:agreement).should == agreement
    end

    it "redirects to #index if :id not found" do
      get :edit, :id => "9999999999"
      expect(response).to redirect_to(agreements_path)
    end

    it "flashes :error if :id not found" do
      get :edit, :id => "7778900000999"
      flash[:error].should_not be_nil
    end
  end

  describe "PUT #update" do
    it "redirects to #index if :agreement updated" do
      agreement = create(:agreement)
      agreement1 = { :author => "Counsel", :version => "3", :name => "boop"}
      put :update, :id => agreement.id, :agreement => agreement1
      expect(response).to redirect_to(agreements_path)
    end

    it "updates :agreement if given proper params" do
      agreement = create(:agreement)
      name = "betty"
      agreement1 = { :author => "Counsel", :version => "1", :name => name}
      put :update, :id => agreement.id, :agreement => agreement1
      agreement.reload
      agreement.name.should == name
    end

    it "flashes :success is not nil if :agreement updated" do
      agreement = create(:agreement)
      agreement1 = { :author => "Counsel", :version => "9", :name => "Jose"}
      put :update, :id => agreement.id, :agreement => agreement1
      flash[:success].should_not be_nil
    end

    it "renders #edit if :agreement not updated" do
      agreement = create(:agreement)
      agreement1 = { :author => "Counsel", :version => "5", :name => ""}
      put :update, :id => agreement.id, :agreement => agreement1
      expect(response).to render_template('edit')
    end

    it "flashes :error is not nil if :agreement not updated" do
      agreement = create(:agreement)
      agreement1 = { :author => "Counsel", :version => "1", :name => ""}
      put :update, :id => agreement.id, :agreement => agreement1
      flash.now[:error].should_not be_nil
    end

  end

  describe "DELETE #destroy" do
    it "redirects to #index if successfully deleted" do
      agreement = create(:agreement)
      delete :destroy, :id => agreement.id
      expect(response).to redirect_to(agreements_path)
    end

    it "flash :success is not nil if :agreement deleted" do
      agreement = create(:agreement)
      delete :destroy, :id => agreement.id
      flash[:success].should_not be_nil
    end

    it "successfully deleted :agreement" do
      agreement = create(:agreement)
      delete :destroy, :id => agreement.id
      Agreement.find_by_id(agreement.id).should be_nil
    end

    it "redirects to referrer if :agreement deletion failed" do
      request.env["HTTP_REFERER"] = "www.whitehouse.gov"
      delete :destroy, :id => 99989889998
      expect(response).to redirect_to("www.whitehouse.gov")
    end

    it "flash :error is not nil if :agreement not deleted" do
      request.env["HTTP_REFERER"] = "www.whitehouse.gov"
      delete :destroy, :id => 999999999999
      flash[:error].should_not be_nil
    end
  end
end
