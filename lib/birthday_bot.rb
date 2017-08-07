require 'httparty'
require 'config_reader'
require 'birthday_reader'

class BirthdayBot 

  def initialize()
    @config = ConfigReader.new
    @config.load('configurations.json')
  end

  def start!
    birthdays = BirthdayReader.get_birthdays(@config.birthdays_path)

    today = Time.now
    puts "Checking who was born today (#{today.to_s})"
    unless birthdays.nil? || birthdays.empty?
      birthdays_today = birthdays[today.month.to_s][today.day.to_s]
      users = build_user_list ( birthdays_today )
      message = "#{users} #{@config.greeting_message}"
      HTTParty.post(@config.slack_url, body: { channel: @config.channel_name,
                                               username: @config.bot_name,
                                               text: message,
                                               icon_emoji: @config.bot_emoji }.to_json)
    else
      puts "Today is a day that no one was born"
    end
  end

  def build_user_list ( birthdays )
    if birthdays.count == 1
      mention birthdays.first
    else
      users = ""
      puts "#{ birthdays.count } people were born today"
      birthdays.take(birthdays.count - 2).each do | birthday |
        users += mention(birthday) + ', '
      end
      users += "#{ mention birthdays[birthdays.count - 2] } and #{ mention birthdays[birthdays.count - 1] }" if birthdays.count > 1
    end
  end

  def mention ( name )
    if @config.mention
      "<@#{ name }>"
    else
      name
    end
  end

end
