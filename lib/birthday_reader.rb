require 'yaml'

class BirthdayReader
  def self.get_birthdays(file_path)
    birthdays = []
    if File.exist?(file_path) 
	bday_list = YAML.load_file(file_path)
	birthdays = bday_list[Time.now.month][Time.now.day]
    end
    return birthdays
  end
end
