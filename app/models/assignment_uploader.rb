require 'csv'

class AssignmentUploader
 
  def initialize(file)
    
    CSV.parse(file.read, :headers => true) do |row|
      @stu= Student.find_by_email(row["Email"])
      Assignment.create(student_id: @stu.id,  name: row["Assignment Name"], total: row["Total"], score: row["Score"]) 
    end
  end
  
end