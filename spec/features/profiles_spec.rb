require 'rails_helper'

describe "Visiting profiles" do

  include TestFactories

  before do
    @user = authenticated_user
    @post = associated_post(user: @user)
    @comment = Comment.new(user: @user, post: @post, body: "A Comment")
    allow(@comment).to receive(:send_favorite_emails)
    @comment.save!
  end

  describe "not signed in" do

    it "shows profile" do
      visit user_path(@user)
      expect(current_path).to eq(user_path(@user))
      expect( page ).to have_content(@user.name)
      expect( page ).to have_content(@post.title)
      expect( page ).to have_content(@comment.body)
    end
  end

  before do
    @user = authenticated_user
    @user.confirmed_at = Time.now
    @user.save
    login_as(@user, :scope => :user)
    @post = associated_post(user: @user)
    @comment = Comment.new(user: @user, post: @post, body: "A Comment")
    allow(@comment).to receive(:send_favorite_emails)
    @comment.save!
  end  

  describe "a user visiting their own profile" do
    it "shows profile" do
      visit user_path(@user)
      expect(current_path).to eq(user_path(@user))
      expect( page ).to have_content(@user.name)
      expect( page ).to have_content(@post.title)
      expect( page ).to have_content(@comment.body)
    end
  end

end
