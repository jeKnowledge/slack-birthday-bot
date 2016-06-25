require 'httparty'
require 'birthday_reader'

class SlackBot

  #initializes the bot with all necessary configurations
  def initialize(url, channel, greeting, botname, emoji)
    @url = url
    @greeting = greeting
    @botname = botname
    @channel = channel
    @emoji = emoji
    BirthdayReader.filepath = 'birthdays.txt'
    if BirthdayReader.file_exist?
      puts 'Found birthdays file'
    else
      abort 'ERROR: Birthdays file not found'
    end
  end

  #prepares the text for output into slack
  def format_text(people, greeting)
    final_names = ''
    counter = 0
    people.each_with_index do |names, counter|
      if counter < people.length - 1
        final_names += "#{names[0]} #{names[1]}, "
      else
        final_names += "#{names[0]} #{names[1]}"
      end
    end
    value = greeting + " :confetti_ball: #{final_names} :confetti_ball:"
  end

  #sends the message through HTTParty with the specific payload and so on
  def push_to_slack(message, channel_name, bot_name, emoji)
    puts '🤖 Bot is notifying Slack...'
    HTTParty.post(@url, body: {channel: channel_name, username: bot_name, text: message, icon_emoji: emoji}.to_json)
    puts "Pushed \"#{message}\""
  end

  #launcher will work whenever the bot is active and does all the work with the specific functions
  def launch!
    birthdays = BirthdayReader.get_birthdays
    newborns = []
    today = DateTime.now.to_date
    print "Checking who was born today (#{today.to_s}): "
    birthdays.each do |person|
      if (person[3].to_i == today.month) and (person[4].to_i == today.day)
        newborns << person
      end
    end
    puts newborns.length
    if newborns.length > 0 then push_to_slack(format_text(newborns, @greeting), @channel, @botname, @emoji) end
  end
end
