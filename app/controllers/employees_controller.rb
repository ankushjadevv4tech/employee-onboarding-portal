class EmployeesController < ApplicationController
  load_and_authorize_resource class: 'User'
  before_action :authenticate_user!
  before_action :set_user, except: [:index, :show, :new, :create]

  def index
    @employees = User.employees
  end

  def new
    @employee = User.new
  end

  def show
    @tasks = current_user.tasks
  end

  def create
    @employee = User.new(employee_params)

    if @employee.save
      redirect_to employees_path, notice: 'Employee created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @employee.update(employee_params)
      redirect_to employees_path, notice: 'Employee updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    redirect_to employees_path, notice: 'Employee deleted successfully.'
  end

  private

  def set_user
    @employee = User.find(params[:id])
  end

  def employee_params
    params.require(:user).permit(:name, :email, :department, :onboarding_status)
  end
end
