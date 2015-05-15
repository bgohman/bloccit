require 'rails_helper'

describe User do

  include TestFactories

  describe "#favorited(post)" do

    before do 
      @post = associated_post
      @other_post = associated_post
      @user = authenticated_user(email_favorites: true)
      end

    it "returns 'nil' if the user has not favorited the post" do
      expect( @user.favorites.find_by_post_id(@post.id) ).to be_nil
    end

    it "returns the appropriate favorite if it exists" do
      favorite = @user.favorites.create(post: @post)
      expect( favorite.post ).to eq(@post)
    end

    it "returns 'nil' if the user has favorited another post " do
      favorite = @user.favorites.create(post: @other_post)
      expect( @user.favorites.find_by_post_id(@post.id) ).to be_nil
    end
  end






end