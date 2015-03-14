require 'httparty'
require 'rufus-scheduler'
require 'file_control'

class SlackBot

	def initialize(url, path=nil)
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
	end

	def introduction
			puts "Welcome to Slack Birthday Bot"
	end

	def shut_down
			puts "\nShutting down! Goodbye!"
			sleep 1
	end

	def format_text(result)
			final_names = ""
			counter = 0
			result.each_with_index do |names, counter|
					if counter <= result.length - 1
						final_names += "#{names[0]} #{names[1]},"
					else
						final_names += "#{names[0]} #{names[1]}"
					end
			end
			if result.length == 1
				birthday_phrase = "A jeKnowledge deseja um feliz aniverário a: #{final_names} continua o óptimo trabalho!"
			else
				birthday_phrase = "A jeKnowledge deseja um feliz aniversário a: #{final_names} continuem o óptimo trabalho!"
			end
	end

	def alert_birthday(message)
		HTTParty.post(@url, body: {channel: "#birthday_test", username: "maximus", text: message, icon_emoji: ":ghost:"}.to_json)
	end

	def launch!

	scheduler = Rufus::Scheduler.new
	birthdays = Birthdays.get_birthdays
	result = []
	time = Time.new
	scheduler.at "1:05:00"  do
		jk_slack_client = SlackBot.new('https://hooks.slack.com/services/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')

		birthdays.each do |pessoa|
			if pessoa[3].to_i == time.month && pessoa[4].to_i == time.day
				result << pessoa
			end
		end
		if result.length != 0
			message = jk_slack_client.alert_birthday(format_text(result))
		end
	end
scheduler.join
	end
end
