class DropTable < ActiveRecord::Migration
  def up
    drop_table :comments
    drop_table :posts
  end
  
  def down
    
  end
end
