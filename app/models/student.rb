require 'digest/md5'
class Student < ActiveRecord::Base

  #attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create
  validates :name, presence: true, length: { minimum: 2 }
  
  has_many :attendances, dependent: :destroy
  
  def self.in_seat(seat, date)
    Student.joins(:attendances).where(attendances: {seat: seat, attended_on: date})
    
  end
  
  def self.absent(date)
    Student.joins(:attendances).where.not(attendances: {attended_on: date})
    
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
