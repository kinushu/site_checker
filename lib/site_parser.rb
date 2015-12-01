require "open-uri"
require "nokogiri"
require 'json'

module SiteParser

  module_function

  def parse_url(url)

    charset = nil
    html = open(url) do |f|
    #  charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)

    result = {
      url: url,
    }

    # 確認開始
    find_path = %*//title*
    doc.xpath(find_path).each do |node|
      result[:title] = node.text
    end

    find_path = %*//a*
    links = {}
    doc.xpath(find_path).each do |node|
      href = node[:href].to_s
      next if href.size == 0

      links[href] = {
        text: node.text,
      }
    end
    result[:links] = links.sort.to_h

    return result
  end

end
