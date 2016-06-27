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
      @slack_url = configs['slack_url']
      @channel_name = configs['channel_name']
      @greeting_message = configs['greeting_message']
      @bot_name = configs['bot_name']
      @bot_emoji = configs['bot_emoji']
    end
  end
end
