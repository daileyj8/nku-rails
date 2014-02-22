class Attendance < ActiveRecord::Base
  belongs_to :student
  
  validates_presence_of :seat, :on => :create
  validates :seat, presence: true
  validates :seat, :inclusion => { :in => 1..4, 
    :notice => "Not a valid seat"}
end
