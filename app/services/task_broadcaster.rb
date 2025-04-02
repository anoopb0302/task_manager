# app/services/task_broadcaster.rb
class TaskBroadcaster
  def self.broadcast_progress
    Rails.logger.info "🔵 TaskBroadcaster: broadcasting progress..."
    
    progress = Task.completed_count
    completed = Task.completed_tasks
    total = Task.total_tasks

    Rails.logger.info "📊 Progress: #{progress}% (#{completed}/#{total} tasks)"

    Turbo::StreamsChannel.broadcast_replace_to(
      "tasks_progress",
      target: "progress-container",
      partial: "tasks/progress",
      locals: { progress: progress, completed: completed, total: total }
    )

    Rails.logger.info "✅ Broadcast sent!"
  end
end
