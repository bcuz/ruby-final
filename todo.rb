# could make an undone or uncheck, where it takes the ***
# off of the description

command, *task_description = ARGV
task_description = task_description.join(" ") + "\n"
task_description.slice! "*** "

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
  attr_accessor :complete

  def initialize(description)
    @description = description
    @complete = false
  end
end

first_list = List.new

# the point of this code is just to put everything that
# already exists in the list, inside of first_list. That's it
File.open("test.txt").each do |line|
  first_list.add_task(Task.new(line))
end

def write_to_file(file, list)
  File.open(file, "w") do |line|
      list.show_all_tasks.each do |task|
      line.puts task.description
      end
    end
  end

case command
  when "add"
    first_list.add_task(Task.new(task_description))

    write_to_file("test.txt", first_list)

    puts "Added"
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

    if task.description == task_description
      task.description = "*** " + new_description
      counter += 1
      end
    end

    if counter < 1
      puts "That task ain't even exist brah"
    else
      puts "Updated"
    end

    write_to_file("test.txt", first_list)

  when "done"

  # one problem here is the truthyness of an objects
  # completeness will always be erased when the program reruns

  # first_list.show_all_tasks.each do |task|
  #     task.complete = true
  #   end

  # another way to go is to put a weird character in front of the
  # completed stuff. Then strip that character(s) away when I want to
  # update the task. I like that idea
    counter = 0
    first_list.show_all_tasks.each do |task|
      if task.description == task_description
        task.description = "*** " + task_description
        counter += 1
      end

    end

    if counter < 1
      puts "That task ain't even exist brah"
    end

    write_to_file("test.txt", first_list)

  when "delete"

    counter = 0
    first_list.show_all_tasks.each do |task|

    task.description.slice! "*** "

    if task.description != task_description
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
      task.description == task_description

    end

    write_to_file("test.txt", first_list)

  when "clear"
    File.truncate("test.txt", 0)
    puts "Done"
  else
    puts "Not an eligible command"
end