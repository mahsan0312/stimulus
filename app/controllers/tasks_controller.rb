class TasksController < ApplicationController
  # We have to build our first action to display all the tasks so # we're gonna fetch all the tasks from the database.
  def index
    @tasks = Task.all.limit(25)
    @task = Task.new
  end
end
