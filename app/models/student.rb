require 'digest/md5'
class Student < ActiveRecord::Base

  #attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  validates :name, presence: true, length: { minimum: 2 }
  
  
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
