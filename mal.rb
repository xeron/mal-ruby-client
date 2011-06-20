# coding: utf-8

# data examples
# Search anime: http://myanimelist.net/api/anime/search.xml?q=full+metal
# Search manga: http://myanimelist.net/api/manga/search.xml?q=full+metal
# api here
# http://myanimelist.net/modules.php?go=api

# Author: Ivan "Xeron" Larionov
# E-mail: xeron.oskom@gmail.com
# Homepage: http://xeron.13f.ru
# Version: none, just draft

require './lib/myanimelist'
require 'optparse'

options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: mal.rb [namespace] [action] [title] [options]
  namespaces:
    anime, manga.
  actions:
    search, add, delete.
  options:"
  opts.on( '-u', '--user USERNAME', 'Username' ) do |u|
    options[:user] = u
  end
  opts.on( '-p', '--password PASSWORD', 'Password' ) do |p|
    options[:password] = p
  end
  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end

begin
  optparse.parse!
rescue => ex
  puts ex
end

if ARGV.length == 0 || ARGV[0].empty?
  puts optparse.help
else
  puts "Doing #{ARGV.join(' ')}"
  m = MyAnimeList.new(ARGV[0], ARGV[1], ARGV[2], options[:user], options[:password])
end