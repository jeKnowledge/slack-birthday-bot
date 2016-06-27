require 'json'

class ConfigReader
  attr_accessor :slack_url,
                :channel_name,
                :greeting_message,
                :bot_name,
                :bot_emoji

  def load(filename)
    if File.exist?(filename)
      file = File.read(filename)
      config = JSON.parse(file)
      @slack_url = config['slack_url']
      @channel_name = config['channel_name']
      @greeting_message = config['greeting_message']
      @bot_name = config['bot_name']
      @bot_emoji = config['bot_emoji']
    end
  end
end
