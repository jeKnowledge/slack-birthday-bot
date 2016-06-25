APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'birthday_bot'
require 'config_control'
require 'httparty'

puts ">> Bot is setting up..."

configs = ConfigReader.new()
if not configs.load('configurations.json')
  abort ">> Bot is shutting down :("
end

puts "Reading configurations"
namefile = 'birthdays.txt'
url = configs.slack_url
channel = configs.channel_name
username = configs.bot_name

puts ">> Bot is launching :)"
bot = SlackBot.new(url, namefile, username, channel)
bot.launch!
