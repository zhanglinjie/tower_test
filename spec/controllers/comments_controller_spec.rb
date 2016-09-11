require 'rails_helper'

describe CommentsController do
  let(:member)   { create :member }
  let(:team) { Action::TeamCreation.new(creator: member, name: generate(:name)).perform! }
  let(:project) { Action::ProjectCreation.new(team: team, creator: member, name: generate(:name)).perform! }
  let(:todo) { Action::TodoCreation.new(project: project, creator: member, name: generate(:name)).perform! }
  let(:comment) { Action::CommentCreation.new(commentable: todo, author: member, content: generate(:content)).perform! }
  let(:common_params) { { format: :js } }
  let(:valid_attributes) { attributes_for(:comment, content: generate(:content), commentable_type: "Todo", commentable_id: todo.id) }
  let(:invalid_attributes) { attributes_for(:comment, content: nil, commentable_type: "Todo", commentable_id: todo.id) }

  before(:each) { sign_in member }

  describe "GET new" do
    it "assigns a new comment_action_creation as @comment_action_creation" do
      xhr :get, :new, { comment: { commentable_type: "Todo", commentable_id: todo.id }}.merge(common_params)
      assigns(:comment_creation).should be_a(Action::CommentCreation)
    end
  end

  describe "GET edit" do
    it "assigns the requested comment as @comment" do
      comment
      xhr :get, :edit, { id: comment.to_param}.merge(common_params)
      assigns(:comment).should == comment
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "create succeed" do
        expect {
          post :create, { comment: valid_attributes}.merge(common_params)
        }.to change(Comment, :count).by(1)
        assigns(:comment).errors.should be_empty
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end
    end

    describe "with invalid params" do
      it "create failed " do
        post :create, { comment: invalid_attributes}.merge(common_params)
        assigns(:comment).should == false
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        attributes_for(:comment, content: "new_content")
      }

      it "update succeed" do
        comment
        put :update, { id: comment.to_param, comment: new_attributes}.merge(common_params)
        comment.reload
        comment.content.should == "new_content"
        assigns(:comment).should == comment
      end
    end

    describe "with invalid params" do
      it "update failed" do
        comment
        put :update, { id: comment.to_param, comment: invalid_attributes}.merge(common_params)
        assigns(:comment).should == comment
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested comment" do
      comment
      expect {
        delete :destroy, { id: comment.to_param}.merge(common_params)
      }.to change(Comment, :count).by(-1)
    end
  end

end
