class TasksController < ApplicationController
  # We have to build our first action to display all the tasks so # we're gonna fetch all the tasks from the database.
  def index
    @tasks = Task.all.limit(25)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: "Task was successfully created" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def toggle
    @task = Task.find_by(id: params[:id].presence)
    @task.update(completed: params[:completed])
    render json: { message: "Success" }
  end

  private
  def task_params
    params.require(:task).permit(:description)
  end
end
