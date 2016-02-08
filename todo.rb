
# takes a command and a string at the command line
command, *task_string = ARGV

# joins the string recieved from the command line
# and add a newline character at the end
# the newline character was being added somewhere by default,
# which is why I add it here. Could look into that
task_string = task_string.join(" ") + "\n"

# Takes away any checkmarks from the task string
# makes it easier to manipulate later. Not really
# sure about that last statement
task_string.slice! "*** "

class List
  def initialize
    @all_tasks = []
    end

    # puts a task in an array
    def add_task(task)
    @all_tasks << task
    end

    # returns the array of tasks
    def show_all_tasks
    @all_tasks
    end

    # opens the file we're manipulating
    # adds any tasks in that file to the list object
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

    # print out the contents of the list after every
    # rewrite
      puts "\nYour list:"

    File.open("test.txt").each do |line|
      puts line
    end
    end
end

class Task
  # description property can be
  # read and rewritten
  attr_accessor :description

  # task just has the description property
  def initialize(description)
    @description = description
  end
end

# creates the new list
first_list = List.new

# put everything that already exists in test.txt
# into a list object. This makes life easier
first_list.existing_list

case command
  when "add"

    counter = 0
    first_list.show_all_tasks.each do |task|

      # loops through the list and
      # if the description of a task equals
      # the string passed into the command line (checked or unchecked)
      # then the counter is increased by one
       if task.description == task_string || task.description == "*** " + task_string
         counter += 1
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

    # this right here probably causes an overwrite
    # problem as seen previously.
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