class AddTopicToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :topic_id, :integer
    add_index :advertisements, :topic_id
  end
end
