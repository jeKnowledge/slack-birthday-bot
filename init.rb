APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'birthday_bot'
require 'rufus-scheduler'
require 'httparty'

#creates a scheduler that will check for birthdays at a specific time
puts "Welcome to BirthdayBot"
puts 'Please enter your slack url:' 
url = gets.chomp
puts 'Please enter your text file with the birth dates and names'
namefile = gets.chomp

scheduler = Rufus::Scheduler.new
scheduler.at "14:23:00" do
	bot = SlackBot.new(url, namefile)
	
	bot.launch!
	end
scheduler.join
