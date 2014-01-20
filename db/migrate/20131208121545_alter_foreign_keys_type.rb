class AlterForeignKeysType < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.change :user_id, :integer
    end

    change_table :comments do |t| 
      t.change :user_id, :integer
      t.change :post_id, :integer
    end
  end
end
