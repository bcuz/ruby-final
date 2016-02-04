# TODO:
# could make an undone or uncheck, where it takes the ***
# off of the description

# could make delete only delete one item that is named that,
# not all items named That
# you typically don't have multiple items on the todo list
# I could give an error if the item is already on the list

command, *task_string = ARGV
task_string = task_string.join(" ") + "\n"
task_string.slice! "*** "

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
  attr_accessor :description

  def initialize(description)
    @description = description
  end
end

first_list = List.new

# put everything that already exists in test.txt
# into a list object. This makes life easier
File.open("test.txt").each do |line|
  first_list.add_task(Task.new(line))
end

# when commands are executed, we just rewrite the list
def write_and_print(list)
  File.open("test.txt", "w") do |line|
      list.show_all_tasks.each do |task|
      line.puts task.description
      end
    end

    puts "\nYour list:"

  File.open("test.txt").each do |line|
    puts line
  end
  end

case command
  when "add"
    first_list.add_task(Task.new(task_string))

    puts "Added"

    write_and_print(first_list)

  when "print"
    File.open("test.txt").each do |line|
      puts line
  end
  when "update"
    puts "Update to what?"
    new_description = STDIN.gets.chomp

    counter = 0
    first_list.show_all_tasks.each do |task|

    task.description.slice! "*** "

    if task.description == task_string
      task.description = "*** " + new_description
      counter += 1
      end
    end

    if counter < 1
      puts "That task ain't even exist brah"
    else
      puts "Updated"
    end

    write_and_print(first_list)

  when "check"
    counter = 0
    first_list.show_all_tasks.each do |task|
      if task.description == task_string
        task.description = "*** " + task_string
        counter += 1
      end
    end

    if counter < 1
      puts "That task ain't even exist brah"
    end

    write_and_print(first_list)

  when "delete"

    counter = 0
    first_list.show_all_tasks.each do |task|

    task.description.slice! "*** "

    if task.description != task_string
      counter += 1
      end
    end

    if counter == first_list.show_all_tasks.length
      puts "that task is not in the list bro"
    else
      puts "Deleted"
    end

    first_list.show_all_tasks.delete_if do |task|
      # task will be deleted if this is true.
      task.description == task_string

    end

    write_and_print(first_list)

  when "clear"
    File.truncate("test.txt", 0)
    puts "Done"
  else
    puts "Not an eligible command"
end