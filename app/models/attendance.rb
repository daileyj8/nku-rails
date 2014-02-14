class Attendance < ActiveRecord::Base
  belongs_to :student
  def self.dup
    grouped= all.group_by{|attendance| [attendance.student_id] }
    grouped.values.each do |duplicates|
      first_one= duplicates.shift
      duplicates.each{|double| double.destroy}
    end
  end
end
