
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

    not_in_list = true
    first_list.show_all_tasks.each do |task|

      # loops through the list and
      # if the description of a task equals
      # the string passed into the command line (checked or unchecked)
      # then we're notified that the task is already in the list
       if task.description == task_string || task.description == "*** " + task_string
         not_in_list = false
       end
     end

     # if teh item is already in the list, notify the user and don't add it
     # otherwise, add it to the list

    if not_in_list == false
      puts "That item is already on the list"
    else
      first_list.add_task(Task.new(task_string))
      puts "\nAdded"
    end

    # writes the adjusted list to the file and prints it too
    first_list.write_and_print

  # just prints the entire list
  when "print"
    File.open("test.txt").each do |line|
      puts line
  end
  when "update"
    puts "Update to what?"
    # STDIN is just some code I got from the error
    # message when I was trying to use gets.chomp
    new_description = STDIN.gets.chomp

    in_list = false
    first_list.show_all_tasks.each do |task|

    # if the unchecked task is in the list
    # change the task's description to the new
    # one saved in the variable above
    if task.description == task_string
      task.description = new_description
      in_list = true

    # if the checked task is in the list
    # change the task description to the new
    # task (checked)
    elsif task.description == "*** " + task_string
      task.description = "*** " + new_description
      in_list = true
      end
    end

    # if the above if statement doesn't execute either
    # branch, the task is not in the list, and the user
    # is given the approporiate response
    if in_list == false
      puts "That task ain't even exist brah"
    else
      puts "\nUpdated"
    end

    first_list.write_and_print

  when "check"
    # checked version of the task string
    checked_task_string = "*** " + task_string

    counter = 0
    checked = false
    first_list.show_all_tasks.each do |task|

      # if the task description (nonchecked) equals the task_string
      # set the task description to the checked version
      if task.description == task_string
        task.description = checked_task_string
        counter += 1

        puts "\nChecked"

      # test whether the task_description is already checked
      elsif task.description == checked_task_string
        checked = true
      end
    end

    # if the unchecked task and the checked task
    # aren't in the list, the task isn't in the list
    if counter < 1 && checked == false
      puts "That task ain't even exist brah"
    # message for tasks that are already checked
    elsif checked
      puts "That task is already checked"
    end

    first_list.write_and_print

  when "uncheck"

    counter = 0
    first_list.show_all_tasks.each do |task|

      # if the task description equals the checked version
      # set it to the nonchecked version
      if task.description == "*** " + task_string
        task.description = task_string
        counter += 1

        puts "\nUnchecked"
      end
    end

    # if the above if statement doesn't execute
    # that means no task matches the checked version
    # of the string given in the command line
    if counter < 1
      puts "That task isn't in the list or isn't checked"
    end

    first_list.write_and_print

  when "delete"

    in_list = false
    first_list.show_all_tasks.each do |task|

    # this loops through the list
    # if the task_string is found (checked or unchecked),
    # in_list variable is changed to true

    if task.description == task_string || task.description == "*** " + task_string
      in_list = true
      end
    end

    # if the task is not found (if statement above never is true)
    # print an error message
    if in_list == false
      puts "that task is not in the list bro"
    else
      puts "\nDeleted"
    end

    first_list.show_all_tasks.delete_if do |task|
      # task will be deleted if this is true.
      task.description == task_string || task.description == "*** " + task_string

    end

    first_list.write_and_print

  when "clear"
    File.truncate("test.txt", 0)
    puts "\nDone"
  else
    puts "Not an eligible command"
end