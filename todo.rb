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
my_list = List.new

case command
  when "add"
    task_obj = Task.new(task_string)
    first_list.add_task(task_obj)

    # this opens the file that may or may not
    # already have todo items, then
    # adds any items that need to be added
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
    # the point of this code is just to put everything that
    # already exists in the list, inside of my_list. That's it
    File.open("test.txt").each do |line|
      my_list.add_task(Task.new(line))
    end

    task_string = task_string + "\n"

    my_list.show_all_tasks.delete_if do |item|
      item.description == task_string
    end

    File.open("test.txt", "w") do |line|
      my_list.show_all_tasks.each do |task|
      line.puts task.description
      end
    end

  when "clear"
    File.truncate("test.txt", 0)
  else
    puts "Not valid"
end