class Attendance < ActiveRecord::Base
  belongs_to :student
  
  validates :seat, :inclusion => { :in => 1..4, 
    :notice => "Not a valid seat"}
end
