APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'birthday_bot'
require 'config_reader'

puts ''
puts '🤖 Bot is booting...'

configs = ConfigReader.new()
if not configs.load('configurations.json')
  abort '❌ Bot is shutting down'
end

puts 'Reading configurations'
url = configs.slack_url
channel = configs.channel_name
username = configs.bot_name
emoji = configs.bot_emoji

puts '🤖 Bot is activating...'
bot = SlackBot.new(url, username, channel, emoji)
bot.launch!
