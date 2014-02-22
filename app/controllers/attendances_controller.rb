class AttendancesController < ApplicationController
  
  def new
    @current = get_current
    if @current= nil
      redirect_to new_session_path
    end
    
    @attendance = Attendance.new
      
    
  end
  
  def create
    @current = get_current
    @attendance = Attendance.new
    @attendance.seat = params[:attendance][:seat]
    @attendance.attended_on = Date.today
    @attendance.student_id= @current.id
    @existing = Attendance.where(:attended_on => Date.today, :student_id => @current.id)
    if (@existing.first == nil)
       if @attendance.save
         redirect_to attendances_path, :notice => "attendance taken"
      else
        render 'new'
      end
      
    else
      flash[:error]= "your attendance has already been taken"
      redirect_to attendances_path
    end
  end
  def index
    @attendances= Attendance.all
    
    
  end
  
  def get_current
    if(session[:student_id] == nil)
      return nil
    else
      return Student.find(session[:student_id])
    end
  end
  
  private
  def get_params
    current = get_current
    params[:attendance][:student_id] = current.id
    params[:attendance][:attended_on] = Date.today
    params.require(:attendance).permit(:seat, :student_id, :attended_on)
    
  end
end
