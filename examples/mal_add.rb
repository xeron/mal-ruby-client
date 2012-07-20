# Example of add use:
# ruby mal_add.rb User Password "Steins;Gate"

require 'pp'

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'myanimelist'

mal = MyAnimeList.new(ARGV[0], ARGV[1])

result = mal.search("anime", ARGV[2])

# Data example
data = {}
# data["episode"] = 0
data["status"] = 1
# data["score"] = 0
# data["downloaded_episodes"] = nil
# data["storage_type"] = nil
# data["storage_value"] = nil
# data["times_rewatched"] = nil
# data["rewatch_value"] = nil
# data["date_start"] = nil
# data["date_finish"] = nil
# data["priority"] = nil
# data["enable_discussion"] = nil
# data["enable_rewatching"] = nil
# data["comments"] = nil
# data["fansub_group"] = nil
# data["tags"] = nil

case result.size
when 0
  puts "#{ARGV[2]} not found."
when 1
  id = mal.add("animelist", result[0][:id], data)
  puts "#{result[0][:title]} #{id}"
else
  puts "Too much results. Select one."
  result.each_with_index { |res, i| puts "#{i + 1}) #{res[:title]} (#{res[:start_date].year} - #{res[:end_date].year}, #{res[:type]}, #{res[:episodes]})" }
  choice = $stdin.gets.chomp
  if choice
    choice = choice.to_i
    if choice > 0 && choice <= result.size
      id = mal.add("animelist", result[choice - 1][:id], data)
      puts "#{result[choice - 1][:title]} #{id}"
    else
      puts "Wrong input. Sorry."
    end
  end
end
