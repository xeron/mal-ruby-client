# data examples
# Search anime: http://myanimelist.net/api/anime/search.xml?q=full+metal
# Search manga: http://myanimelist.net/api/manga/search.xml?q=full+metal
# api here
# http://myanimelist.net/modules.php?go=api

# Author: Ivan "Xeron" Larionov
# E-mail: xeron.oskom@gmail.com
# Homepage: http://xeron.13f.ru
# Version: 0.1

require 'rubygems'
require 'net/http'
require 'uri'
require 'nokogiri'

class MyAnimeList

  API_BASE_URL = "http://myanimelist.net/api/"

  def initialize(user, password)
    @user = user
    @password = password
  end

  private

  def do_request(url, method = "POST", data = nil)
    uri = URI.parse(API_BASE_URL + URI.escape(url))
    http = Net::HTTP.new(uri.host, uri.port)

    case method
    when "GET"
      request = Net::HTTP::Get.new(uri.request_uri, "Accept" => "application/xml")
    when "POST"
      request = Net::HTTP::Post.new(uri.request_uri, "Accept" => "application/xml")
      request.content_type = "application/x-www-form-urlencoded"
      request.body = "data=#{data}" if data
    end

    request.basic_auth(@user, @password)
    response = http.request(request)

    case response
    when Net::HTTPSuccess, Net::HTTPRedirection
      return response.body
    else
      return response.value
    end
  end

  def parse_xml(data)
    result = Nokogiri::XML(data)
    return result.child.xpath("entry")
  end

  def format_values(data)
    Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.entry {
        data.each do |key, val|
          xml.send(key.to_sym, val)
        end
      }
    end.to_xml
  end

end
