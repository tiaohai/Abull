require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #edit_real_name" do
    it "assigns all funds as @users" do
      user = create(:user)
      get :edit_real_name, {id: user.to_param}
      expect(assigns(:user)).to eq user
    end
  end


  describe "POST #update_real_name" do
    context "with valid params" do
      it "updates the requested user with real_name,
          assgin the requested user as @user,
          redirect_to the user" do
        user = create(:user)
        put :update_real_name, {id: user.to_param, user: {real_name: "new_real_name", password: user.password}}
        user.reload
        expect(user.real_name).to eq "new_real_name"
        expect(assigns(:user)).to eq user
        expect(response).to       redirect_to user
      end
    end

    context "with invalid params" do
      it "assigns the user as @user,
          re_renders the 'edit' template" do
        user = create(:user)
        put :update_real_name, {id: user.to_param, user: {real_name: "new_real_name", password: "wrongpassword"}}
        expect(assigns(:user)).to eq user
        expect(response).to       render_template("edit_real_name")
      end
    end
  end
end