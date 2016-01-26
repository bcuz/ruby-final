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
replace_filter = Task.new("Replace water filter")
do_nothing = Task.new("Sit around and not do anything")



first_list.add_task(replace_filter)
first_list.add_task(do_nothing)

# puts first_list.show_all_tasks.inspect