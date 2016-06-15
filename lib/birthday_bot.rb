require 'httparty'
require 'rufus-scheduler'
require 'file_control'

class SlackBot

  #it initializes the bot with the url of slack and the path of the file

  def initialize(url, path, user, channel)
    @url = url
    Birthday.filepath = path
    if Birthday.file_exists?
      puts "Found aniversary file"
    elsif Birthday.create_file
      puts "An aniversary file was created"
    else
      puts "Nothing to be done! Goodbye!\n\n"
      exit!
    end
    @username = user
    @channel = channel
  end

  #prepares the text for output into slack
  def format_text(result)
    final_names = ""
    counter = 0
    result.each_with_index do |names, counter|
      if counter < result.length - 1
        final_names += "#{names[0]} #{names[1]}, "
      else
        final_names += "#{names[0]} #{names[1]}"
      end
    end
    if result.length == 1
      birthday_phrase = "A EqualExperts deseja um feliz aniverário a: #{final_names}. Parabéns! :tada:"
    else
      birthday_phrase = "A EqualExperts deseja um feliz aniversário a: #{final_names} Parabéns! :tada:"
    end
  end

  #sends the message through HTTParty with the specific payload and so on
  def alert_birthday(message, chann, user)
    HTTParty.post(@url, body: {channel: chann, username: user, text: message, icon_emoji: ":david:"}.to_json)
  end

  #launcher will work whenever the bot is active and does all the work with the specific functions
  def launch!
    scheduler = Rufus::Scheduler.new
    birthdays = Birthday.get_birthdays
    result = []
    time = Time.new
    scheduler.at "9:00" do
      birthdays.each do |pessoa|
        if pessoa[3].to_i == time.month && pessoa[4].to_i == time.day
          result << pessoa
        end
      end
      if result.length != 0
        puts format_text(result)
        alert_birthday(format_text(result), @channel, @username)
      end
    end
  end
end

