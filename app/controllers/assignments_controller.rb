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
      redirect_to assignments_path
    else
      render 'new'
    end
  end
  
  def index
    @current= get_current
    @assignments= Assignment.all
    @students= Student.all
    
    unless session[:student_id] != nil
      flash[:notice] = "You must log in!"
      redirect_to new_session_path
      return
    end
    if @current.admin
      if params[:student_id]
        @stu= Student.find(params[:student_id])
        @assignments= @stu.assignments
      end
    end
  end
  
  def student_percentage
    (all.to_f / all_count)
  end
  
  def destroy
    @assignment= Assignment.find(params[:id])
    @assignment.destroy
    redirect_to assignments_path, notice: "Assignment successfully deleted."
  end
  
  def import
    before= Assignment.all.size
    AssignmentUploader.new(params[:file])
    after= Assignment.all.size
    redirect_to "/assignments", notice: "#{after - before} Assignments Imported."
    #redirect_to students_path, notice: "Students imported."
  end
  
  def edit
    
  end
  
  def show
    @current= get_current
    unless @current.admin
      redirect_to "/assignments"
    end
  end
    
end
