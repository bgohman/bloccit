class AddUserAndPostToSummaries < ActiveRecord::Migration
  def change
    add_column :summaries, :user_id, :integer
    add_index :summaries, :user_id
    add_column :summaries, :post_id, :integer
    add_index :summaries, :post_id
  end
end
