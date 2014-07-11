require 'spec_helper'

describe EventsController do
  describe "Get index" do
    it "current user sees his events" do
      alice = Fabricate(:user)
      set_current_user(alice)
      event = Fabricate(:event, user_id: alice.id, public_event: false)
      get :index
      expect(assigns(:events)).to eq([event])
    end

    it "user can't sees events another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      set_current_user(alice)
      event = Fabricate(:event, user_id: bob.id, public_event: false)
      get :index
      expect(assigns(:events)).not_to eq([event])
    end

    it "user can see public events" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      event = Fabricate(:event, user_id: bob.id, public_event: true )
      set_current_user(alice)
      get :index
      expect(assigns(:events)).to eq([event])
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end
  end
end