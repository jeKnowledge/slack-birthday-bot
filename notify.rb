APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'birthday_bot'
require 'json'
require 'httparty'

puts ">> Bot is setting up..."
file = File.read('configs.json')
configs = JSON.parse(file)

puts 'Validating configurations'
if not configs.key?('SlackUrl')
  abort('ERROR: Missing "SlackUrl" on configuration file')
elsif not configs.key?('ChannelName')
  abort('ERROR: Missing "ChannelName" on configuration file')
elsif not configs.key?('BotName')
  abort('ERROR: Missing "BotName" on configuration file')
end

puts "Reading configurations"
namefile = 'birthdays.txt'
url = configs['SlackUrl']
channel = configs['ChannelName']
username = configs['BotName']

puts ">> Bot is launching!"
bot = SlackBot.new(url, namefile, username, channel)
bot.launch!
