class BirthdayReader
  @@filepath = nil

  def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT, path)
  end

  #checks if the file we are looking exists in the correct directory
  def self.file_exist?
    return (@@filepath and File.exist?(@@filepath))
  end

  #checks if the file is valid
  def self.file_usable?
    return false unless @@filepath
    return false unless File.exist?(@@filepath)
    return false unless File.readable?(@@filepath)
    return true
  end

  #if file doesnt exist it creates one
  def self.create_file
    File.open(@@filepath, 'w') unless file_exist?
    return file_usable?
  end

  #gets the array of that line in predefined order (1st name, last name, year, month, day)
  def import_line(line)
    line_array = line.split(' ')
    @first_name, @last_name, @year, @month, @day = line_array
    return line_array
  end

  #creates the final array that will be worked with
  def self.get_birthdays
    birthdays = []
    if file_usable?
      print 'Parsing names and birthdays (count='
      file = File.new(@@filepath, 'r')
      file.each_line do |line|
        birthdays << BirthdayReader.new.import_line(line.chomp)
      end
      puts "#{birthdays.length})"
      file.close
    else
      abort 'ERROR: Birthday file is not usable'
    end
    return birthdays
  end
end
