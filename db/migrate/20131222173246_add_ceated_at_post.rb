class AddCeatedAtPost < ActiveRecord::Migration
  def change
    add_column :posts, :created_at, :timestamp
  end
end
