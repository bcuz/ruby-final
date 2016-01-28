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

# def show(first_list)
#   first_list.show_all_tasks.each do |task|
#     puts task.description
#   end
# end

case command
  when "add"
    task_obj = Task.new (task_string)
    first_list.add_task(task_obj)
end

File.open("test.txt", "a") do |line|
    first_list.show_all_tasks.each do |task|
    line.puts "\r" + task.description
  end
end

# is there a way to save the program? so i can add during one run
# of the program and then view on another. Using a case
# might be easier once using text files is incorporated

# might be better to always print to a file...
# show(my_list)