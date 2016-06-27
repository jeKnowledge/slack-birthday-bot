APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'birthday_bot'

puts '🤖  Bot is starting ...'
bot = BirthdayBot.new
bot.start!
puts '🤖  Bot is shutting down ...'
