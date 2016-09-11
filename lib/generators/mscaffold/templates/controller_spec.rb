require 'rails_helper'

describe <%= controller_class_name %>Controller do
  let(:member)   { create :member }
  let(:<%= singular_name %>) { create :<%= singular_name %> }
  let(:common_params) { {} }
  let(:valid_attributes) { attributes_for(:<%= singular_name %>, name: generate(:name)) }
  let(:invalid_attributes) { attributes_for(:<%= singular_name %>, name: nil) }

  before(:each) { sign_in member }

  describe "GET index" do
    it "assigns all <%= plural_name%> as @<%= plural_name%>" do
      <%= singular_name %>
      get :index, common_params
      assigns(:<%= plural_name%>).should == [<%= singular_name %>]
    end
  end

  describe "GET show" do
    it "assigns the requested <%= singular_name %> as @<%= singular_name %>" do
      <%= singular_name %>
      get :show, { id: <%= singular_name %>.to_param}.merge(common_params)
      assigns(:<%= singular_name %>).should == <%= singular_name %>
    end
  end

  describe "GET new" do
    it "assigns a new <%= singular_name %> as @<%= singular_name %>" do
      get :new, common_params
      assigns(:<%= singular_name %>).should be_a_new(<%= class_name %>)
    end
  end

  describe "GET edit" do
    it "assigns the requested <%= singular_name %> as @<%= singular_name %>" do
      <%= singular_name %>
      get :edit, { id: <%= singular_name %>.to_param}.merge(common_params)
      assigns(:<%= singular_name %>).should == <%= singular_name %>
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "create succeed" do
        expect {
          post :create, { <%= singular_name %>: valid_attributes}.merge(common_params)
        }.to change(<%= class_name %>, :count).by(1)
        assigns(:<%= singular_name %>).errors.should be_empty
        assigns(:<%= singular_name %>).should be_a(<%= class_name %>)
        assigns(:<%= singular_name %>).should be_persisted
        response.should redirect_to([<%= class_name %>.last])
      end
    end

    describe "with invalid params" do
      it "create failed " do
        post :create, { <%= singular_name %>: invalid_attributes}.merge(common_params)
        assigns(:<%= singular_name %>).should be_a_new(<%= class_name %>)
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        attributes_for(:<%= singular_name %>, name: "new_name")
      }

      it "update succeed" do
        <%= singular_name %>
        put :update, { id: <%= singular_name %>.to_param, <%= singular_name %>: new_attributes}.merge(common_params)
        <%= singular_name %>.reload
        <%= singular_name %>.name.should == "new_name"
        assigns(:<%= singular_name %>).should == <%= singular_name %>
        response.should redirect_to([<%= singular_name %>])
      end
    end

    describe "with invalid params" do
      it "update failed" do
        <%= singular_name %>
        put :update, { id: <%= singular_name %>.to_param, <%= singular_name %>: invalid_attributes}.merge(common_params)
        assigns(:<%= singular_name %>).should == <%= singular_name %>
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested <%= singular_name %>" do
      <%= singular_name %>
      expect {
        delete :destroy, { id: <%= singular_name %>.to_param}.merge(common_params)
      }.to change(<%= class_name %>, :count).by(-1)
      response.should redirect_to([:<%= plural_name%>])
    end
  end

end
