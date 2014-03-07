class Assignments < ActiveRecord::Migration
  def change
    
    create_table :assignments do |t|
      t.integer :score
      t.integer :total
      

      t.timestamps
    end
  end
end
