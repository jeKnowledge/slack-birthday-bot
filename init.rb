APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'birthday_bot'
require 'rufus-scheduler'
require 'httparty'

scheduler = Rufus::Scheduler.new
scheduler.at "14:00:00" do
	bot = SlackBot.new("your slack url here!", 'your text file here!')
	
	bot.launch!
	end
scheduler.join
