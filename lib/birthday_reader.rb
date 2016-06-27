class BirthdayReader
  def self.get_birthdays(file_path)
    birthdays = []
    if File.exist?(file_path) 
      file = File.new(file_path, 'r')
      file.each_line do |line|
        birthdays << line.chomp.split
      end
      file.close
    end
    return birthdays
  end
end
