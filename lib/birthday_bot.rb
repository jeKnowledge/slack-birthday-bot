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

    puts "Checking who was born today (#{Time.now.to_s})"
    unless birthdays.nil?
      users = "#{ mention birthdays[0] }"
      if birthdays.count > 1
        puts "#{ birthdays.count } people were born today"
        if birthdays.count == 2
          users = " #{ mention birthdays[0] } and #{ mention birthdays[1] } "
        else
           for i in 1..birthdays.count-2
             users.concat( ", #{ mention birthdays[i] }" )
           end
           users.concat( " and #{ mention birthdays[i+1] } " )
        end
      end
      message = "#{users} #{@config.greeting_message}"
      HTTParty.post(@config.slack_url, body: { channel: @config.channel_name,
                                               username: @config.bot_name,
                                               text: message,
                                               icon_emoji: @config.bot_emoji }.to_json)
    else
      puts "Today is a day that no one was born"
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
