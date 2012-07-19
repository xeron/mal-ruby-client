class MyAnimeList

  # Allows the authenticating user to search anime/manga titles.
  # http://myanimelist.net/api/anime|manga/search.xml?q=full+metal
  # === Returns
  # Array:: Hashes of found titles
  def search(namespace, title)
    if xml = do_request("#{namespace}/search.xml?q=#{title}", "GET")
      items = parse_xml(xml)
      return reformat_items(items)
    else
      return []
    end
  end

  private

  def reformat_items(items)
    result = []

    items.each do |item|
      result << {
        :id => item.xpath("id").text.to_i,
        :title => item.xpath("title").text,
        :english => item.xpath("english").text,
        :synonyms => item.xpath("synonyms").text,
        :episodes => item.xpath("episodes").text.to_i,
        :score => item.xpath("score").text.to_f,
        :type => item.xpath("type").text,
        :status => item.xpath("status").text,
        :start_date => Time.new(item.xpath("start_date").text),
        :end_date => Time.new(item.xpath("end_date").text),
        :synopsis => item.xpath("synopsis").text,
        :image => item.xpath("image").text
      }
    end

    return result
  end

end
