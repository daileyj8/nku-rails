class Attendance < ActiveRecord::Base
  belongs_to :student
  def self.dup
    grouped= all.group_by{|attendance| [attendance.student_id,attendance.attended_on] }
    grouped.values.each do |duplicates|
      first_one= duplicates.shift
      duplicates.each{|double| double.destroy}
    end
  end
  validates :seat, :inclusion => 1..4
end
