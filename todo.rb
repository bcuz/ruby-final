class List
  def initialize (description)
    @all_tasks = []
    end

    def add_task(tasks)
    @all_tasks << task
    end

    def show_all_tasks
    @all_tasks
    end
end

class Task
  attr_reader :description
  def initialize(description)
    @description = description
  end
end

thing = Task.new("blah blah")
puts thing