class StudentsController < ApplicationController

  def new
    @student = Student.new
  end
  
  def create
    @student = Student.new(params[:student].permit(:name, :nickname, :email, :image))
    
    if @student.save
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
    @student.destroy
    redirect_to students_path
  end
  
  private
  def student_params
    params.require(:student).permit(:name, :nickname, :email, :image)
  end
  
end
