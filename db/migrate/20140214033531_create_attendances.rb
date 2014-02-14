class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :seat
      t.integer :student_id
      t.date :attended_on

      t.timestamps
    end
  end
end
