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
    if @current == nil
      redirect_to new_session_path
    end
    @attendance = Attendance.new(get_params)
    if @attendance.save
      redirect_to attendances_path
    else
      redirect_to 'new'
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
