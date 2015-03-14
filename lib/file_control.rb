class Birthday
  @@filepath = nil

  def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT, path)
  end

  #checks if the file we are looking exists in the correct directory
  def self.file_exists?
    if @@filepath && File.exists?(@@filepath)
      return true
    else
      return false
    end
  end

  #checks if the file is valid
  def self.file_usable?
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return true
  end

  #if file doesnt exist it creates one
  def self.create_file
    File.open(@@filepath, 'w') unless file_exists?
    return file_usable?
  end

  #gets the array of that line in predefined order(1st name, last name, year, month, day)
  def import_line(line)
    line_array = line.split(' ')
    @primeiro_nome, @ultimo_nome, @ano, @mes, @dia = line_array
    return line_array
  end

  #creates the final array that will be worked with
  def self.get_birthdays
    birthdays = []
    if file_usable?
      file = File.new(@@filepath, 'r')
      file.each_line do |line|
        birthdays << Birthday.new.import_line(line.chomp)
      end
      file.close
    end
    return birthdays
  end
end
