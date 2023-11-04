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

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url, notice: "Task was successfully updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    debugger
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_url, notice: "Post was successfully deleted."
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end
end
