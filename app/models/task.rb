class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :status, type: String, default: "To do"

  validates :title, presence: true

  STATUSES = ["To do", "In Progress", "Completed"].freeze

  def completed?
    status == "Completed"
  end

  scope :completed, -> { where(status: "Completed") }

  def self.completed_count
    completed.count
  end

  def self.completed_tasks
    completed.count
  end

  def self.total_tasks
    count
  end


  after_create -> { TaskBroadcaster.broadcast_progress }
  after_update -> { TaskBroadcaster.broadcast_progress }
end

