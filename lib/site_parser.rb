require "uri"
require "open-uri"
require "nokogiri"
require 'json'

module SiteParser

  class LinkInfo
    def initialize(href:"", text:"", uri:nil)
      @conf = {
        href: href,
        text: text || "",
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

    request_uri = URI.parse(url)

    src_charset = open(url).charset
    dst_charset = "utf-8"
    html = open(url, 'r:binary').read.encode(dst_charset, src_charset, :invalid => :replace, :undef => :replace)

    doc = Nokogiri::HTML.parse(html, nil, dst_charset)

    result = {
      url: url,
    }

    # 確認開始
    find_path = %*//title*
    result[:title] = url.to_s
    doc.xpath(find_path).each do |node|
      result[:title] = node.text
    end

    find_path = %*//a*
    links = {}
    doc.xpath(find_path).each do |node|
      href = node[:href].to_s
      next if href.size == 0

      uri = URI.parse(href) rescue nil
      next unless uri

      if request_uri.host == uri.host
        uri.host = ""
      end

      next if uri.host.present? # hostがある場合、外部リンクとして無視する

      now_path = uri.path
      next if now_path.blank?

      if now_path[0] == '.' || now_path[0] != '/'
        href = URI.join(request_uri.to_s, uri.path).to_s
        uri = URI.parse(href)
      end

      links[href] = LinkInfo.new(href: href, text: node.text, uri: uri)

    end
    result[:links] = links.sort.to_h

    return result
  end

end
