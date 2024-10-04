class TasksController < ApplicationController
  before_action :set_user, only: %i[index new create edit update destroy mark_completed upload_document]
  before_action :set_task, only: %i[edit update destroy mark_completed upload_document]
  load_and_authorize_resource

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
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def mark_completed
    @task.update(status: 'completed')
    redirect_to user_tasks_path(@user), notice: 'Task marked as completed.'
  end

  def upload_document
    @task.update(document: params[:document])
    redirect_to employee_path(current_user), notice: 'Document uploaded successfully.'
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
