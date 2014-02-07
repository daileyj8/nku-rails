class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :nickname
      t.string :email
      t.string :image
      t.string :password_digest
      
      t.timestamps
    end
  end
end
