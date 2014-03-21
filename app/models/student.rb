require 'digest/md5'
class Student < ActiveRecord::Base

  #attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create
  validates :name, presence: true, length: { minimum: 2 }
  validates_inclusion_of :admin, :in => [true, false]
  has_many :attendances, dependent: :destroy
  has_many :assignments, dependent: :destroy
  
  def self.in_seat(seat, date)
    Student.joins(:attendances).where(attendances: {seat: seat, attended_on: date})
    
  end
  
  def present
    return (@in1.count+@in2.count+@in3.count+@in4.count)
  end
  
  def self.absent(now)
    where.not(id: present(now))
  end

  def self.present(now)
    joins(:attendances).where(attendances: {attended_on: now})
  end
  
  def self.absentObsolete(date)
    Student.joins(:attendances).where.not(attendances: {attended_on: date})
    
  end
  
  def self.absent2(date)
    attendances = Attendance.where(date)
    students = attendances.collect{ |a| a.student_id }
    Student.where.not(id: students)
  end
  
  validates :password,
    :length => { :minimum => 5, :if => :validate_password? },
    :confirmation => { :if => :validate_password? }

  private

  def validate_password?
    password.present? || password_confirmation.present?
  end
  
#  def grav_url
#    if student.image != ""
#      return student.image
#    elsif student.email != ""
#      email_address= (student.email).downcase
#      hash = Digest::MD5.hexdigest(email_address)
#      return "http://www.gravatar.com/avatar/#{hash}"
#    else
#      return "http://premium.wpmudev.org/blog/wp-content/uploads/2012/04/mystery-man-small.jpg"
#  end  
end
