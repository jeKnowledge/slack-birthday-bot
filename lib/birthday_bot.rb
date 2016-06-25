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
    value = 'A EqualExperts deseja um feliz aniverário.' + " ➡ #{final_names} :tada:"
  end

  #sends the message through HTTParty with the specific payload and so on
  def alert_birthday(message, chann, user)
    HTTParty.post(@url, body: {channel: chann, username: user, text: message, icon_emoji: ":david:"}.to_json)
  end

  #launcher will work whenever the bot is active and does all the work with the specific functions
  def launch!
    birthdays = BirthdayReader.get_birthdays
    result = []
    time = Time.new
    birthdays.each do |person|
      if person[3].to_i == time.month && person[4].to_i == time.day
        result << person
      end
    end
    if result.length != 0
      puts format_text(result)
      alert_birthday(format_text(result), @channel, @username)
    end
  end
end
