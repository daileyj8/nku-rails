class Assignment < ActiveRecord::Base
  validates :student_id, :uniqueness => { :scope => :name }
  validates_presence_of :score, :on => :create
  validates_presence_of :total, :on => :create
  validates_presence_of :name, :on => :create
  validates_presence_of :student_id, :on => :create
  validates :score, numericality: {
    only_integer: true,
  }
  validates :total, numericality: {
    only_integer: true,
  }

  def student_percentage(all, all_count)
    (all.to_f / all_count)
  end
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