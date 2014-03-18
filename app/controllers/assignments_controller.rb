class AssignmentsController < ApplicationController
  
  def new
    @assignment= Assignment.new
    unless session[:student_id] != nil
      flash[:notice] = "You must log in!"
      redirect_to new_session_path
      return
    end
    @current= get_current
    unless @current.admin
      flash[:notice] = "You do not have permission to do that"
      redirect_to students_path
      return
    end
  end
  
  def create
    unless session[:student_id] != nil
      flash[:notice] = "You must log in!"
      redirect_to new_session_path
      return
    end
    @current= get_current
    unless @current.admin
      flash[:notice] = "You do not have permission to do that"
      redirect_to students_path
      return
    end
    @students=Student.all
    @assignment= Assignment.new
    @assignment.name = params[:assignment][:name]
    @assignment.score = params[:assignment][:score]
    @assignment.total = params[:assignment][:total]
    @assignment.student_id = params[:assignment][:student_id]
    if @assignment.save
      redirect_to students_path
    else
      render 'new'
    end
  end
  
  def index
    @current= get_current
    @assignments= Assignment.all
    unless session[:student_id] != nil
      flash[:notice] = "You must log in!"
      redirect_to new_session_path
      return
    end
  end
  
  def show
  end
  
  
end
