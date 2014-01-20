 class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.string :user_id, :post_id
      t.timestamp
    end
  end
end
