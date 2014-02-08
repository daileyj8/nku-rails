class StudentsController < ApplicationController
 
  
  def new
    @student = Student.new
  end
  
  def login_required
    unless Student.find(session[:student_id]) != nil
      flash[:alert] = 'Log In!'
      redirect_to new_session_path
    end
  end
      
  def create
    @student = Student.new(params[:student].permit(:name, :nickname, :email, :image, :password, :password_confirmation))
    
    if @student.save
      session[:student_id] = @student.id
      redirect_to students_path, notice: "Student successfully created."
      
    else
      render 'new'
    end
  end
  
  def show
    @student = Student.find(params[:id])
    
  end
  
  def index
    @students = Student.all
  end
  
  def edit
    @student = Student.find(params[:id])
     unless session[:student_id] == @student.id
      flash[:notice] = "You dont have access to that profile!"
      redirect_to students_path
      return
    end
  end
  
  def update
    @student = Student.find(params[:id])
    if @student.update(params[:student].permit(:name, :nickname, :email, :image))
      redirect_to students_path, notice: "Student successfully updated."
    else
      render 'edit'
    end
  end
  
  def destroy
    @student = Student.find(params[:id])
    session.destroy
    @student.destroy
    redirect_to new_session_path, notice: "Student successfully deleted."
  end
  
  private
  def student_params
    params.require(:student).permit(:name, :nickname, :email, :image)
  end
  
end
