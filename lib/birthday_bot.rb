require 'httparty'
require 'config_reader'
require 'birthday_reader'

class SlackBot
  def initialize()
    @config = ConfigReader.new
    @config.load('configurations.json')
  end

  def start!
    birthdays = BirthdayReader.get_birthdays()
    today = Time.now 

    print "Checking who was born today (#{today.to_s}): "
    birthdays.each do |b|
      if (b[3].to_i == today.month) && (b[4].to_i == today.day)
        message = "#{@config.greeting_message} #{b[0]} #{b[1]}" 
        HTTParty.post(@config.slack_url, body: { channel: channel_name,
                                                 username: bot_name,
                                                 text: message,
                                                 icon_emoji: emoji }.to_json)
      end
    end
  end
end
