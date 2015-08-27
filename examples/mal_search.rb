# Example of search use:
# ruby mal_search.rb User Password "Steins;Gate"

require 'pp'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'myanimelist'

mal = MyAnimeList.new(ARGV[0], ARGV[1])

result = mal.search("anime", ARGV[2])
pp result
