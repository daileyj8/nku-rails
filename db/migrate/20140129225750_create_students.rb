class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :nickname
      t.string :email
      t.string :image
      t.string :password_digest
      t.boolean :absent
      t.integer :in_seat
      t.timestamps
    end
  end
end
