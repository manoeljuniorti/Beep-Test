require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      expect(create(:comment)).to be_valid
    end

    it "is invalid without a story" do
      expect(build(:comment, story: nil)).not_to be_valid
    end

    it "is invalid without text" do
      expect(build(:comment, text: nil)).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to a story" do
      comment = create(:comment)
      expect(comment).to respond_to(:story)
    end
  end
end