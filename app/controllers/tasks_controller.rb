class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy, :change_status]
  
    def index
      @tasks = Task.all
      @completed = Task.where(status: "Completed").count
      @total = Task.count
      @progress = (@total.positive? ? (@completed.to_f / @total * 100).round : 0)
      respond_to do |format|
        format.html # Normal HTML request
        format.turbo_stream # Turbo-enabled requests
      end
      
    end
  
    def show; end
  
    def new
      @task = Task.new
    end
  
    def create
      @task = Task.new(task_params)
      if @task.save
        update_progress
        respond_to do |format|
          format.html { redirect_to tasks_path, notice: "Task created successfully." }
          format.turbo_stream # Renders create.turbo_stream.erb
        end
        broadcast_progress
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    # def edit
    #   respond_to do |format|
    #     format.turbo_stream
    #     format.html
    #   end
    # end    
  

    def edit    
      respond_to do |format|
        format.turbo_stream
        format.html  # Fallback for non-Turbo requests
      end
    end

    def update
      if @task.update(task_params)
        update_progress
    
        respond_to do |format|
          format.turbo_stream # Renders update.turbo_stream.erb
          format.html { redirect_to tasks_path, notice: "Task updated successfully." }
        end
        broadcast_progress
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      if @task.status == "Completed"
        @task.destroy
        respond_to do |format|
          format.html { redirect_to tasks_path, notice: "Task deleted successfully." }
          format.turbo_stream # Renders destroy.turbo_stream.erb
        end
      else
        redirect_to tasks_path, alert: "Only completed tasks can be deleted."
      end
    end
  
    def change_status
    end
  
    private
  
    def set_task
      @task = Task.find(params[:id])
    end
  
    def task_params
      params.require(:task).permit(:title, :description, :status)
    end

    def update_progress
      @tasks = Task.all
      @completed = Task.where(status: "Completed").count
      @total = Task.count
      @progress = (@total.positive? ? (@completed.to_f / @total * 100).round : 0)
    end

    def broadcast_progress
      Turbo::StreamsChannel.broadcast_replace_to(
        "tasks_progress",
        target: "progress-container",
        partial: "tasks/progress",
        locals: { progress: @progress, completed: @completed, total: @total }
      )
    end
  end
  