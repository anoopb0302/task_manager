class ProgressController < ApplicationController
  def index
    total_tasks = Task.count
    completed_tasks = Task.where(status: "Completed").count
    progress = total_tasks.zero? ? 0 : (completed_tasks.to_f / total_tasks * 100).round

    respond_to do |format|
      format.html { render partial: "tasks/progress", locals: { progress: progress, completed: completed_tasks, total: total_tasks } }
      format.json { render json: { progress: progress, completed: completed_tasks, total: total_tasks } }
    end
  end

  def show
    tasks = Task.all
    completed_tasks = tasks.where(status: "Completed").count
    total_tasks = tasks.count
    progress_percentage = total_tasks.zero? ? 0 : (completed_tasks.to_f / total_tasks * 100).round

    render json: {
      completed: completed_tasks,
      total: total_tasks,
      percentage: progress_percentage
    }
  end
end
