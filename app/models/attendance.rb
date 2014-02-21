class Attendance < ActiveRecord::Base
  belongs_to :student
  
  validates :seat, :inclusion => 1..4
end
