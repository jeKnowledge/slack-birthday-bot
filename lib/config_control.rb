require 'json'

class ConfigReader

  attr_accessor :slack_url, :channel_name, :bot_name

  # Reads a JSON file containing the configurations
  def load(filename)
    file = File.read(filename)
    @configs = JSON.parse(file)

    if valid?
      @slack_url = @configs['SlackUrl']
      @channel_name = @configs['ChannelName']
      @bot_name = @configs['BotName']
      value = true
    else
      value = false
    end
  end

  # Returns true if the last configurations loaded is valid
  def valid?
    puts 'Validating configurations'
    value = false
    if @configs.nil?
      puts 'ERROR: Configuration file not found'
    elsif not @configs.key?('SlackUrl')
      puts 'ERROR: Missing "SlackUrl" on configuration file'
    elsif not @configs.key?('ChannelName')
      puts 'ERROR: Missing "ChannelName" on configuration file'
    elsif not @configs.key?('BotName')
      puts 'ERROR: Missing "BotName" on configuration file'
    else
      value = true
    end
  end

end
