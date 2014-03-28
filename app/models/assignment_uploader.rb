require 'csv'

class AssignmentUploader
 
  def initialize(file)
    
    CSV.parse(file.read, :headers => true) do |row|
      @stu= Student.find_by_email(row["Email"])
      assign= Assignment.where("student_id=? AND name=?", @stu.id, row["Assignment Name"])
      if assign.size == 0
        Assignment.create(student_id: @stu.id,  name: row["Assignment Name"], total: row["Total"], score: row["Score"])
      else
        assign= assign.first
        assign.total = row["Total"]
        assign.score = row["Score"]
        assign.save!
      end
    end
  end
  
end