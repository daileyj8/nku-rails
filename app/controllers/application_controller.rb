class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery 

  before_filter :authenticate_student, :only => [:edit, :update, :show, :index]
  
  def login_required
    unless Student.find(session[:student_id]) != nil
      flash[:alert] = 'Log In!'
      redirect_to new_session_path
    end
  end
  
  def authenticate_student
    if session[:student_id]
      @current_student = Student.find(session[:student_id])
      return true
    else
      redirect_to(:controller => 'sessions', :action => 'new')
      return false
    end
  end
  
  def save_login_state
    if session[:student_id]
      redirect_to(:controller => 'sessions', action => 'home')
      return false
    else
      return true
    end
  end

  
end
