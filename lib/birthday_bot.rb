require 'httparty'
require 'birthday_reader'

class SlackBot

  #initializes the bot with all necessary configurations
  def initialize(url, user, channel)
    @url = url
    @username = user
    @channel = channel
    BirthdayReader.filepath = 'birthdays.txt'
    if BirthdayReader.file_exist?
      puts 'Found birthdays file'
    else
      abort 'ERROR: Birthdays file not found'
    end
  end

  #prepares the text for output into slack
  def format_text(result)
    final_names = ''
    counter = 0
    result.each_with_index do |names, counter|
      if counter < result.length - 1
        final_names += "#{names[0]} #{names[1]}, "
      else
        final_names += "#{names[0]} #{names[1]}"
      end
    end
    value = 'A EqualExperts dá os parabéns!' + " :confetti_ball: #{final_names} :confetti_ball:"
  end

  #sends the message through HTTParty with the specific payload and so on
  def push_to_slack(message, chann, user)
    puts '🤖 Bot is notifying Slack...'
    HTTParty.post(@url, body: {channel: chann, username: user, text: message, icon_emoji: ":david:"}.to_json)
    puts "Pushed \"#{message}\""
  end

  #launcher will work whenever the bot is active and does all the work with the specific functions
  def launch!
    birthdays = BirthdayReader.get_birthdays
    result = []
    today = DateTime.now.to_date
    print "Checking who was born today (#{today.to_s}): "
    birthdays.each do |person|
      if (person[3].to_i == today.month) and (person[4].to_i == today.day)
        result << person
      end
    end
    puts result.length
    if result.length > 0 then push_to_slack(format_text(result), @channel, @username) end
  end
end
