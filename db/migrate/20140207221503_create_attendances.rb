class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|

      
      t.attendance
      t.attended_on
      t.seat
      
      t.timestamps
    end
  end
end
