class StudentsController < ApplicationController

  def new
  end
  
  def create
    @student = Student.new(student_params)
    @student.save
    redirect_to @student
  end
  
  def show
    @student = Student.find(params[:id])
  end
  
  def index
    @students = Student.all
  end
  
  private
  def student_params
    params.require(:student).permit(:name, :nickname, :email, :image)
  end
  
end
