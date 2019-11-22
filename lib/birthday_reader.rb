require 'yaml'

class BirthdayReader
  def self.get_birthdays(file_path)
    if File.exist?(file_path) 
	return YAML.load_file(file_path)
    end
  end
end
