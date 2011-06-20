# coding: utf-8

require 'rubygems'
require 'open-uri'
require 'nokogiri'

class MyAnimeList

  def initialize(namespace, action, title, user, password)
    raise ArgumentError, "Invalid namespase." unless ["anime", "manga"].include? namespace
    raise ArgumentError, "Invalid action." unless ["search", "add", "update", "delete"].include? action
  end

end