class RemovePostCAtegory < ActiveRecord::Migration
  def change
  	drop_table :post_categories
  end
end
