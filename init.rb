APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'birthday_bot'

bot = SlackBot.new("https://hooks.slack.com/services/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", 'aniversarios.txt')
bot.launch!
