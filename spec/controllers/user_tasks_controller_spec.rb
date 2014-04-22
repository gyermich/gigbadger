require 'spec_helper'

describe UserTasksController do
  include Devise::TestHelpers

   before(:each) do
     @request.env["devise.mapping"] = Devise.mappings[:user]
     @user = FactoryGirl.create(:user)
     sign_in @user
   end
  
  describe "create" do
    context "when badger does not exist" do  
      let(:user) { create(:user)}
      it "places an offer" do 
        task = create(:task)

        post :create, task_id: task.id

        expect(response).to redirect_to(task_path(task))

        expect(UserTask.find_by(user_id: @user.id, task_id: task.id)).to_not be nil
      end
    end
  end
end