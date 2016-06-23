APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'birthday_bot'
require 'httparty'

puts "Bot is reading configs..."
url = ''
namefile = 'birthdays.txt'
channel = ''
username = ''

puts "Bot is launching!"
bot = SlackBot.new(url, namefile, username, channel)
bot.launch!
end
