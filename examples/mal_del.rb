# Example of del use:
# ruby mal_del.rb User Password "Steins;Gate"

require 'pp'

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'myanimelist'

mal = MyAnimeList.new(ARGV[0], ARGV[1])

result = mal.search("anime", ARGV[2])

case result.size
when 0
  puts "Nothing found."
when 1
  puts mal.delete("animelist", result[0][:id])
else
  puts "Too much results. Select one."
  result.each_with_index { |res, i| puts "#{i + 1}) #{res[:title]}" }
  choice = $stdin.gets.chomp
  if choice
    choice = choice.to_i
    if choice > 0 && choice <= result.size
      puts mal.delete("animelist", result[choice - 1][:id])
    else
      puts "Wrong input. Sorry."
    end
  end
end
