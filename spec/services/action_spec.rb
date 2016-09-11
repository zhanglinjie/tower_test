require "rails_helper"
describe Action do
  let(:member){ create :member }
  let(:action_invalid){ Action::TeamCreation.new(name: nil, creator: member)}

  describe "action invalid" do
    it "should perform! raise error" do
      expect {
        action_invalid.perform!
      }.to raise_error(Action::InvalidError)
    end

    it "should has error after valid" do
      action_invalid.valid?
      action_invalid.errors.should be_present
    end

    it "should return false when perform" do
      action_invalid.perform.should == false
    end
  end
end