class TasksController < ApplicationController
  load_and_authorize_resource

  before_action :set_task, except: %i[index new create]

  def index
    @completed_tasks = Task.completed
    @pending_tasks = Task.pending
    @upcoming_tasks = Task.upcoming
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
    redirect_to employee_path(current_user), notice: 'Task marked as completed.'
  end

  def upload_document
    @task.update(document: params[:document])
    redirect_to employee_path(current_user), notice: 'Document uploaded successfully.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :status, :assigned_to_id, :document)
  end
end
