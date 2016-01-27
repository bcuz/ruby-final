command, *task_description = ARGV
task_string = task_description.join(" ")

class List
  def initialize
    @all_tasks = []
    end

    def add_task(task)
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

first_list = List.new

if command == "add"
  task_obj = Task.new (task_string)
  first_list.add_task(task_obj)
end

first_list.show_all_tasks.each do |task|
  puts task.description
end