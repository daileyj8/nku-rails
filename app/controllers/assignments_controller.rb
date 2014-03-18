class AssignmentsController < ApplicationController
  
  def new
    @assignment= Assignment.new
  end
  
  def create
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
