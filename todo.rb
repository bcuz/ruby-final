# TODO:

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

    def existing_list
      File.open("test.txt").each do |line|
        self.add_task(Task.new(line))
      end
    end

    # when commands are executed, we just rewrite the list
    def write_and_print
    File.open("test.txt", "w") do |line|
        self.show_all_tasks.each do |task|
        line.puts task.description
        end
      end

      puts "\nYour list:"

    File.open("test.txt").each do |line|
      puts line
    end
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
first_list.existing_list

case command
  when "add"

    counter = 0
    first_list.show_all_tasks.each do |task|

       if task.description == task_string
         counter += 1
       elsif task.description == "*** " + task_string
       end
     end

    if counter >= 1
      puts "That item is already on the list"
    else
      first_list.add_task(Task.new(task_string))
      puts "Added"
    end

    first_list.write_and_print

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

    first_list.write_and_print

  when "check"
    checked_task_string = "*** " + task_string

    counter = 0
    checked = false
    first_list.show_all_tasks.each do |task|

      if task.description == task_string
        task.description = checked_task_string
        counter += 1

        puts "\nChecked"
      elsif task.description == checked_task_string
        checked = true
      end
    end

    if counter < 1 && checked == false
      puts "That task ain't even exist brah"
    elsif checked
      puts "That task is already checked"
    end

    first_list.write_and_print

  when "uncheck"

    counter = 0
    first_list.show_all_tasks.each do |task|

      if task.description == "*** " + task_string
        task.description = task_string
        counter += 1

        puts "Unchecked"
      end
    end

    if counter < 1
      puts "That task isn't in the list or isn't checked"
    end

    first_list.write_and_print

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

    first_list.write_and_print

  when "clear"
    File.truncate("test.txt", 0)
    puts "Done"
  else
    puts "Not an eligible command"
end