require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new( content: "This incident is cool!", reported_incident: FactoryBot.create(:reported_incident)) }
  it "is valid with valid attributes" do
      expect(subject).to be_valid
  end
  it "is not valid without a content" do
      expect(subject.content).not_to be_nil
  end
  it "is not valid without a incident" do
      expect(subject.reported_incident_id).to_not be_nil
  end
end
