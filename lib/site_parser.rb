require "uri"
require "open-uri"
require "nokogiri"
require 'json'

module SiteParser

  class Link
    def initialize(href:"", text:"", uri:nil)
      @conf = {
        href: href,
        text: text,
        uri:  uri,
      }
    end

    def href
      @conf[:href]
    end
    def text
      @conf[:text]
    end
    def real_href
      uri = @conf[:uri]
      [uri.scheme, "://", uri.host, @conf[:href]].join
    end

  end

  module_function

  def parse_url(url)

    uri = URI.parse(url)

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

      links[href] = Link.new(href: href, text: node.text, uri: uri)

    end
    result[:links] = links.sort.to_h

    return result
  end

end
