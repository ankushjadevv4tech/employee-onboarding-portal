class TasksController < ApplicationController
  before_action :set_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @completed_tasks = Task.where(status: 'completed')
    @pending_tasks = Task.where(status: 'pending')
    @upcoming_tasks = Task.where('due_date > ?', Date.today)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'Task created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task deleted successfully.'
  end

  def mark_completed
    @task = Task.find(params[:id])
    @task.update(status: 'completed')
    redirect_to tasks_path, notice: 'Task marked as completed.'
  end

  private

  def set_user
    @user = User.find(params[:user_id]) if params[:user_id]
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :status, :assigned_to_id, :document)
  end
end
