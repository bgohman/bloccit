require 'rails_helper'

describe Vote do

    before do
      @post = Post.create(title: 'post title', body: 'Post bodies must be pretty long.')
      @invalid_vote = @post.votes.create(value: 0)
      @valid_vote = @post.votes.create(value: -1)
    end

  describe "valid post validations" do
    describe "value validations" do
      it "only allows -1 or 1 as values" do
        expect( @valid_vote.valid? ).to eq(true)
      end
    end
  end

  describe "validations" do
    describe "value validations" do
      it "only allows -1 or 1 as values" do
        expect( @invalid_vote.valid? ).to eq(false)
      end
    end
  end

end