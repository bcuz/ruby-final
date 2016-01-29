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
current_list = []

File.open("test.txt").each do |line|
    current_list << line
  end

case command
  when "add"
    task_obj = Task.new(task_string)
    first_list.add_task(task_obj)

    File.open("test.txt", "a") do |line|
      first_list.show_all_tasks.each do |task|
      line.puts task.description
      end
    end
  when "print"
    File.open("test.txt").each do |line|
    puts line
  end
  when "done"
    task_string = task_string + "\n"
    current_list.each do |item|
      if task_string == item
        current_list.delete(item)
      end
    end
    # puts current_list
  when "clear"
    File.open("test.txt", "w")
  else
    puts "Not valid"
end