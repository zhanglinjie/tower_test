require "rails_helper"
describe Action::CommentCreation do
  let(:member){ create :member }
  let(:team){ Action::TeamCreation.new(name: generate(:name), creator: member).perform! }
  let(:project){ Action::ProjectCreation.new(name: generate(:name), creator: member, team: team).perform! }
  let(:todo){ Action::TodoCreation.new(name: generate(:name), creator: member, project: project).perform! }

  describe "perform with valid data" do
    it "should create comment" do
      expect{
          comment = Action::CommentCreation.new(content: generate(:content), author: member, commentable: todo).perform!
          comment.should be_a(Comment)
          comment.author.should == member
          comment.commentable.should == todo
        }.to change(Event::CommentCreation, :count).by(1)
      comment = Comment.last
      event = Event::CommentCreation.last
      event.source.should == comment
    end
  end
end