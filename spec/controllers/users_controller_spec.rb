require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = User.create(twitter_id: 1234567890)
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, id: @user.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:attr) do
        {twitter_id: 987654321}
      end
      it "redirects to edit page after updating" do
        post :create, user: attr
        user = User.find_by(twitter_id: 987654321)
        expect(response).to redirect_to(edit_user_path(user))
      end
      it "creates a new user" do
        expect{post :create, user: attr}.to change(User,:count).by(1)
      end
    end

    context "with invalid attributes" do
      let(:attr) do
        {gender: "test"}
      end
      it "does not save the new user" do
        expect{post:create, user: attr}.to_not change(User,:count)
      end

      it "re-renders the new user form" do
        post:create, user: attr
        expect(response).to render_template :new
      end
    end
  end

  describe "POST #update" do
    let(:attr) do
      { gender: "test" }
    end

    before(:each) do
      post :update, id: @user.id, user: attr
    end

    it "updates the user" do
      @user.reload
      expect(@user.gender).to eq("test")
    end

    it "redirects to edit page after updating" do
      expect(response).to redirect_to(edit_user_path)
    end
  end

end
