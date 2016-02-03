command, *task_description = ARGV
task_string = task_description.join(" ") + "\n"
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
    first_list.add_task(Task.new(task_string))

    # this opens the file that may or may not
    # already have todo items, then
    # adds any items that need to be added
    File.open("test.txt", "a") do |line|
      first_list.show_all_tasks.each do |task|
      line.puts task.description
      end
    end

    puts "Added"
  when "print"
    File.open("test.txt").each do |line|
    puts line
  end
  when "update"
    puts "Update to what?"
    new_item = STDIN.gets.chomp

    counter = 0
    first_list.show_all_tasks.each do |item|
    if item.description == task_string
      item.description = new_item
      counter += 1
      end
    end

    if counter < 1
      puts "That item ain't even exist brah"
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
  # update the item. I like that idea
  counter = 0
  first_list.show_all_tasks.each do |item|
    if item.description == task_string
      item.description = "*** " + task_string
      counter += 1
    end

  end

  if counter < 1
    puts "That item ain't even exist brah"
  end

  write_to_file("test.txt", first_list)

  when "delete"

    counter = 0
    first_list.show_all_tasks.delete_if do |item|
      if item.description != task_string
        counter += 1
      end

      if counter == first_list.show_all_tasks.length
        puts "that item is not in the list bro"
      else
        puts "Deleted"
      end

      item.description == task_string

    end

    write_to_file("test.txt", first_list)

  when "clear"
    File.truncate("test.txt", 0)
    puts "Done"
  else
    puts "Not an eligible command"
end