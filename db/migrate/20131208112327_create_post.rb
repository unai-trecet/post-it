class CreatePost < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url, :title, :user_id
      t.text :description
      t.timestamp
    end
  end
end
