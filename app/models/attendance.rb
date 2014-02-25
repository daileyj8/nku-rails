class Attendance < ActiveRecord::Base
  belongs_to :student
  
  validates :attended_on, uniqueness: {scope: :student_id, message: "you already logged your attendance today"}
  validates :seat, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 4
  }
  
  validates_presence_of :seat, :on => :create
  validates :seat, presence: true
  validates :seat, :inclusion => { :in => 1..4, 
    :notice => "Not a valid seat"}
end
