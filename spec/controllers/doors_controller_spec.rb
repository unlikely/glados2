require 'spec_helper'

describe DoorsController do
    describe "GET #index" do
        it "populates an index" do
            door = create(:door)
            get :index
            assigns(:doors).should == [ door ]
        end

        it "renders #index" do
            door = create(:door)
            get :index
            expect(response).to render_template('index')
        end
    end

    describe "GET #show" do
        it "renders #show if :id is valid" do
            door = create(:door)
            get :show, :id => door.id
            expect(response).to render_template("show")
        end

        it "populates :door from valid :id" do
            door = create(:door)
            get :show, :id => door.id
            assigns(:door).should == door
        end

        it "redirects to #index if agreement isn't found" do
            get :show, :id => "98987979797"
            expect(response).to redirect_to(doors_path)
        end

        it "flashes :error if door not found" do
            get :show, :id => "8887778989"
            flash[:error].should_not be_nil
        end
    end

    describe "GET #new" do
        it "renders #new" do
            get :new
            expect(response).to render_template('new')
        end

        it "creates empty :door object" do
            get :new
            assigns(:door).id.should be_nil
        end
    end

    describe "POST #create" do
        it "redirects to #index if :door saves" do
          door_attr = attributes_for(:door)
          post :create, :door => door_attr
          expect(response).to redirect_to(doors_path)
        end

        it "flashes :success if :door saved" do
          door_attr = attributes_for(:door)
          post :create, :door => door_attr
          flash[:success].should_not be_nil
        end

        it "creates new :door" do
          curr_count = Door.count
          door_attr = attributes_for(:door)
          post :create, :door => door_attr
          Door.count.should == 1 + curr_count
        end

        it "renders #new if :door not saved" do
          door_attr = attributes_for(:door, :name => "")
          post :create, :door => door_attr
          expect(response).to render_template('new')
        end

        it "flashes :error if :door not saved" do
          door_attr = attributes_for(:door, :name => "")
          post :create, :door => door_attr
          flash[:error].should_not be_nil
        end
    end

    describe "GET #edit" do
      it "renders #edit if :id is correct" do
        door = create(:door)
        get :edit, :id => door.id
        expect(response).to render_template('edit')
      end

      it "finds associated :door if correct :id" do
        door = create(:door)
        get :edit, :id => door.id
        assigns(:door).should == door
      end

      it "redirects to #index if :id not found" do
        get :edit, :id => "8998398333"
        expect(response).to redirect_to(doors_path)
      end

      it "flashes an error if :id not found" do
        get :edit, :id => "89898989"
        flash[:error].should_not be_nil
      end
    end

    describe "PUT #update" do
     it "redirects to #index if :door updated" do
       door_attr = attributes_for(:door, :name => "something else")
       door = Door.create(door_attr)
       put :update, :id => door.id, :door => door_attr
       expect(response).to redirect_to(doors_path)
     end

     it "updates :door if given proper params" do
       door_attr = attributes_for(:door, :name => "yet another thing")
       door = Door.create(door_attr)
       put :update, :id => door.id, :door => door_attr
       door.reload
       door.name.should == door_attr[:name]
     end

     it "flashes :success is not nill if :door is updated" do
       door_attr = attributes_for(:door, :name => "another thing")
       door = Door.create(door_attr)
       put :update, :id => door.id, :door => door_attr
       flash.now[:success].should_not be_nil
     end

     it "renders #edit if :door not updated" do
       door_attr = attributes_for(:door, :name => "")
       door = create(:door)
       put :update, :id => door.id, :door => door_attr
       expect(response).to render_template("edit")
     end

     it "flashes an error if :door not updated" do
       door_attr = attributes_for(:door, :name => "")
       door = create(:door)
       put :update, :id => door.id, :door => door_attr
       flash[:error].should_not be_nil
     end
    end

    describe "DELETE #destroy" do
      it "redirects to #index if successfully deleted" do
        door = create(:door)
        delete :destroy, :id => door.id
        expect(response).to redirect_to(doors_path)
      end

      it "flash :success is not nill if deleted" do
        door = create(:door)
        delete :destroy, :id => door.id
        flash[:success].should_not be_nil
      end

      it "succesfully deleted :door" do
        door = create(:door)
        delete :destroy, :id => door.id
        Door.find_by_id(door.id).should be_nil
      end

      it "redirects to referrer if :door deletion failed" do
        request.env["HTTP_REFERER"] = "www.whitehouse.gov"
        delete :destroy, :id => "999090999"
        expect(response).to redirect_to("www.whitehouse.gov")
      end

      it "flash :error is not nil if :door not deleted" do
        request.env["HTTP_REFERER"] = "www.whitehouse.gov"
        delete :destroy, :id => "999090999"
        flash[:error].should_not be_nil
      end
    end
end
