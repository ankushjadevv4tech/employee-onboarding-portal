class EmployeesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource class: 'User'

  def index
    @employees = User.where(role: 'employee')
  end

  def new
    @employee = User.new
  end

  def show
    @user = current_user
    @tasks = current_user.tasks
  end

  def create
    @employee = User.new(employee_params)
    @employee.role = 'employee'
    @employee.password = Devise.friendly_token[0, 20]

    if @employee.save
      redirect_to employees_path, notice: 'Employee created successfully.'
    else
      render :new
    end
  end

  def edit
    @employee = User.find(params[:id])
  end

  def update
    @employee = User.find(params[:id])
    if @employee.update(employee_params)
      redirect_to employees_path, notice: 'Employee updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @employee = User.find(params[:id])
    @employee.destroy
    redirect_to employees_path, notice: 'Employee deleted successfully.'
  end

  private

  def employee_params
    params.require(:user).permit(:name, :email, :department, :onboarding_status)
  end
end
