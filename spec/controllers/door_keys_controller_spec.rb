require 'spec_helper'

describe DoorKeysController do
  describe "GET #index" do
    it "renders #index" do
      door_keys = create(:door_key)
      get :index
      expect(response).to render_template('index')
    end

    it "populates :door_keys" do
      door_key = create(:door_key)
      get :index
      assigns(:door_keys).should == [ door_key ]
    end
  end

  describe "GET #show" do
    it "renders #show if :id is valid" do
      door_key = create(:door_key)
      get :show, :id => door_key.id
      expect(response).to render_template('show')
    end

    it "populates :door_key from a valid :id" do
      door_key = create(:door_key)
      get :show, :id => door_key.id
      assigns(:door_key).should == door_key
    end

    it "redirect to #index if :door_key not found" do
      get :show, :id => 90909090909
      expect(response).to redirect_to(door_keys_path)
    end

    it "flashes :error if :door_key not found" do
      get :show, :id => 9989879797
      flash[:error].should_not be_nil
    end
  end

  describe "GET #new" do
    it "renders #new" do
      get :new
      expect(response).to render_template('new')
    end

    it "creates empty :door_key object" do
      get :new
      assigns(:door_key).id.should be_nil
    end
  end

  describe "POST #create" do
    it "redirects to #index if :door_key saved" do
      door_key = build(:door_key).attributes.except("created_at", "updated_at", "id")
      post :create, :door_key => door_key
      expect(response).to redirect_to(door_keys_path)
    end

    it "flashes :success if :door_key saved" do
      door_key = build(:door_key).attributes.except("created_at", "updated_at", "id")
      post :create, :door_key => door_key
      flash[:success].should_not be_nil
    end

    it "creates new :door_key" do
      door_key = build(:door_key).attributes.except("created_at", "updated_at", "id")
      door_key_count = DoorKey.count
      post :create, :door_key => door_key
      DoorKey.count.should == 1 + door_key_count
    end

    it "renders #new if :door_key not saved" do
      door_key = build(:door_key, :person_id => "").attributes.except("created_at", "updated_at", "id")
      post :create, :door_key => door_key
      expect(response).to render_template('new')
    end

    it "flashes #error if :door_key not saved" do
      door_key = build(:door_key, :person_id => "").attributes.except("created_at", "updated_at", "id")
      post :create, :door_key => door_key
      flash[:error].should_not be_nil
    end
  end

  describe "GET #edit" do
    it "renders #edit if :id is correct" do
      door_key = create(:door_key)
      get :edit, :id => door_key.id
      expect(response).to render_template('edit')
    end

    it "finds associated :door_key if correct :id" do
      door_key = create(:door_key)
      get :edit, :id => door_key.id
      assigns(:door_key).id.should == door_key.id
    end

    it "redirects to #index if :door_key not found" do
      get :edit, :id => "90980809098"
      expect(response).to redirect_to(door_keys_path)
    end

    it "flashes :error if :door_key not found" do
      get :edit, :id => "09809809808"
      flash[:error].should_not be_nil
    end
  end

  describe "PUT #update" do
    it "redirects to #index if updated" do
      person = create(:person)
      door_key = create(:door_key, :person_id => person.id)
      door_key_attr = door_key.attributes.except("created_at", "updated_at", "id")
      put :update, :id => door_key.id, :door_key => door_key_attr
      expect(response).to redirect_to(door_keys_path)
    end

    it "flashes :success if updated" do
      person = create(:person)
      door_key = create(:door_key, :person_id => person.id)
      door_key_attr = door_key.attributes.except("created_at", "updated_at", "id")
      put :update, :id => door_key.id, :door_key => door_key_attr
      flash[:success].should_not be_nil
    end

    it ":door_key is updated" do
      person = create(:person)
      door_key = create(:door_key, :person_id => person.id)
      door_key_attr = door_key.attributes.except("created_at", "updated_at", "id")
      put :update, :id => door_key.id, :door_key => door_key_attr
      door_key.id.should == person.id
    end

    it "renders #edit if not updated" do
      door_key = create(:door_key)
      door_key_attr = door_key.attributes.except("created_at", "updated_at", "id")
      door_key_attr["person_id"] = ""
      put :update, :id => door_key.id, :door_key => door_key_attr
      expect(response).to render_template('edit')
    end

    it "flashes :error if not updated" do
      door_key = create(:door_key)
      door_key_attr = door_key.attributes.except("created_at", "updated_at", "id")
      door_key_attr["person_id"] = ""
      put :update, :id => door_key.id, :door_key => door_key_attr
      flash[:error].should_not be_nil
    end
  end

  describe "DELETE #destroy" do
    it "redirects to #index if deleted" do
      door_key = create(:door_key)
      delete :destroy, :id => door_key.id
      expect(response).to redirect_to(door_keys_path)
    end

    it "flashes :success is not nil if :door_keys deleted" do
      door_key = create(:door_key)
      delete :destroy, :id => door_key.id
      expect(response).to redirect_to(door_keys_path)
      flash[:success].should_not be_nil
    end

    it "successfully deleted :door_key" do
      door_key = create(:door_key)
      delete :destroy, :id => door_key.id
      DoorKey.find_by_id(door_key.id).should be_nil
    end

    it "redirects to referrer if :door_key deletion failed" do
      url = "www.blah.com"
      request.env["HTTP_REFERER"] = url
      delete :destroy, :id => 8989898989898
      expect(response).to redirect_to(url)
    end

    it "redirects to referrer if :door_key deletion failed" do
      url = "www.blah.com"
      request.env["HTTP_REFERER"] = url
      delete :destroy, :id => 989809777575
      flash[:error].should_not be_nil
    end
  end

end
