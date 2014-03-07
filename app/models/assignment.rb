class Assignment < ActiveRecord::Base
  
  def self.average_percentage
    assignments=Assignment.all
    total=0
    assignments.each do |assign|
      total= total + assign.percentage
    end
    return (total.to_f / assignments.count)
  end
  
  def percentage
    (score.to_f / total) * 100
    
  end
  
end