class AttendancesController < ApplicationController
  
  def new
    unless session[:student_id] != nil
      flash[:notice] = "You must log in!"
      redirect_to new_session_path
      return
    end
    
    @attendance = Attendance.new
         
  end
  
  def show
    @student = params[:id]
    @attendances= Attendance.all
    unless session[:student_id] != nil
      flash[:notice] = "You must log in!"
      redirect_to new_session_path
      return
    end
    @current= get_current
  end
  
  def create
    @current = get_current
    @attendance = Attendance.new
    @attendance.seat = params[:attendance][:seat]
    @attendance.attended_on = Date.today
    @attendance.student_id= @current.id
    @existing = Attendance.where(:attended_on => Date.today, :student_id => @current.id)
   
    if @attendance.save
      redirect_to attendances_path, :notice => "attendance taken"
    else
      render 'new'
    end 
   
  end
  
  def index
    @attendances= Attendance.all
    @current= get_current
    
  end
  
 
end
