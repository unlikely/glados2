require 'spec_helper'

describe FobsController do
  describe "GET #index" do
    it "populates :fobs" do
      fob = create(:fob)
      get :index
      assigns(:fobs).should == [ fob ]
    end

    it "renders #index" do
      fob = create(:fob)
      get :index
      expect(response).to render_template('index')
    end
  end

  describe "GET #show" do
    it "renders #show if :id is valid" do
      fob = create(:fob)
      get :show, :id => fob.id
      expect(response).to render_template('show')
    end

    it "populates :fob from valid :id" do
      fob = create(:fob)
      get :show, :id => fob.id
      assigns(:fob).should == fob
    end

    it "redirects to #index if the fob isn't found" do
      get :show, :id => "99898798798797"
      expect(response).to redirect_to(fobs_path)
    end

    it "flashes an :error when fob not found" do
      get :show, :id => "99898798798797"
      flash[:error].should_not be_nil
    end
  end

  describe "GET #new" do
    it "renders #new" do
      get :new
      expect(response).to render_template('new')
    end

    it "creates empty :fob object" do
      get :new
      assigns(:fob).id.should be_nil
    end
  end

  describe "POST #create" do
    it "redirects to #index if :fob saved" do
      fob_attr = attributes_for(:fob)
      post :create, :fob => fob_attr
      expect(response).to redirect_to(fobs_path)
    end

    it "flashes :success if :fob safed" do
      fob_attr = attributes_for(:fob)
      post :create, :fob => fob_attr
      flash[:success].should_not be_nil
    end

    it "creates new :fob" do
      curr_count = Fob.count
      fob_attr = attributes_for(:fob)
      post :create, :fob => fob_attr
      Fob.count.should == 1 + curr_count
    end

    it "renders #new if :fob not saved" do
      fob_attr = attributes_for(:fob, :key => "")
      post :create, :fob => fob_attr
      expect(response).to render_template('new')
    end

    it "flashes :error if :fob not saved" do
      fob_attr = attributes_for(:fob, :key => "")
      post :create, :fob => fob_attr
      flash.now[:error].should_not be_nil
    end
  end

  describe "GET #edit" do
    it "renders #edit if :id correct" do
      fob = create(:fob)
      get :edit, :id => fob.id
      expect(response).to render_template('edit')
    end

    it "finds associated :fob with correct :id" do
      fob = create(:fob)
      get :edit, :id => fob.id
      assigns(:fob).should == fob
    end

    it "redirects to #index if :fob not found" do
      get :edit, :id => "111112133"
      expect(response).to redirect_to(fobs_path)
    end

    it "flashes :error if :fob not found" do
      get :edit, :id => "111112133"
      flash[:error].should_not be_nil
    end
  end

  describe "PUT #update" do
    it "redirects to #index if :door updated" do
      fob_attr = attributes_for(:fob, :key => "newkey")
      fob = create(:fob)
      put :update, :id => fob.id
      expect(response).to redirect_to(fobs_path)
    end

    it "updates :fob if given proper params" do
      fob_attr = attributes_for(:fob, :key => "anotherkey")
      fob = create(:fob)
      put :update, :id => fob.id, :fob => fob_attr
      fob.reload
      fob.key.should == "anotherkey"
    end

    it "flashes :success is not nill if fob is updated" do
      fob_attr = attributes_for(:fob, :key => "newkey")
      fob = create(:fob)
      put :update, :id => fob.id, :fob => fob_attr
      flash.now[:success].should_not be_nil
    end

    it "renders #edit if fob not updated" do
      fob_attr = attributes_for(:fob, :key => "")
      fob = create(:fob)
      put :update, :id => fob.id, :fob => fob_attr
      expect(response).to render_template('edit')
    end

    it "flashes an error if :fob not updated" do
      fob_attr = attributes_for(:fob, :key => "")
      fob = create(:fob)
      put :update, :id => fob.id, :fob => fob_attr
      flash.now[:error].should_not be_nil
    end
  end

    describe "DELETE #destroy" do
      it "redirects to #index if successfully deleted" do
        fob = create(:fob)
        delete :destroy, :id => fob.id
        expect(response).to redirect_to(fobs_path)
      end

      it "flashes :success is not nil if :fobs deleted" do
        fob = create(:fob)
        delete :destroy, :id => fob.id
        flash[:success].should_not be_nil
      end

      it "succesfully deleted :fob" do
        fob = create(:fob)
        delete :destroy, :id => fob.id
        Fob.find_by_id(fob.id).should be_nil
      end

      it "redirects to referrer if :fob deletion failed" do
        request.env["HTTP_REFERER"] = "www.whitehouse.gov"
        delete :destroy, :id => "89898989898"
        expect(response).to redirect_to("www.whitehouse.gov")
      end

      it "flash :error is not nil if :fob not deleted" do
        request.env["HTTP_REFERER"] = "www.whitehouse.gov"
        delete :destroy, :id => "89890909"
        flash[:error].should_not be_nil
      end
    end
end
