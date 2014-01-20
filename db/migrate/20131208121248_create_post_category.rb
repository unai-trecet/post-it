class CreatePostCategory < ActiveRecord::Migration
  def change
    create_table :post_categories do |t|
      t.integer :category_id, :post_id
      t.timestamp
    end
  end
end
