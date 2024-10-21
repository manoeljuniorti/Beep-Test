require 'rails_helper'

RSpec.describe Story, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      expect(create(:story)).to be_valid
    end

    it "is invalid without a title" do
      expect(build(:story, title: nil)).not_to be_valid
    end

    it "is invalid without a url" do
      expect(build(:story, url: nil)).not_to be_valid
    end
  end

  describe "associations" do
    it "has many comments" do
      story = create(:story)
      expect(story).to respond_to(:comments)
    end
  end
end
