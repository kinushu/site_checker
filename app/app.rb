require_relative '../lib/site_parser'

module Kpckara
  class App < Padrino::Application
    register ScssInitializer
    use ConnectionPoolManagement
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    before do
      @app_config = settings.config
    end

    def to_url_path_with(uri)
      path = uri.path
      path << ['?', uri.query].join if uri.query
      path << ['#', uri.fragment].join if uri.fragment
      return path
    end

    def prepare
      return unless @url 

      @uri_info = URI.parse(@url)
      @res = SiteParser::parse_url(@url)

      tgt_link = 
        Link.where( 
          {uri_host: @uri_info.host, uri_path: to_url_path_with(@uri_info)} ).first_or_initialize
      tgt_link.update!(
        title: @res[:title], checked_at: Time.now )

      @res[:links].each do |href, info|
        # p info
        uri = URI.parse(info.href)
        path = to_url_path_with(uri)
        link = 
          Link.where( 
            {uri_host: @uri_info.host, uri_path: path} ).first_or_initialize
#        p link

        unless link.persisted?
          link.update!(title: info.text)

#          p "saved"
#          p link
        end
      end

      @links = Link.where(uri_host: @uri_info.host).order(:uri_path)

    end

    # トップページ
    get '/' do
      @url = params[:url] # "/Users/kinukawa/develop/helper/sitemap_creator/check.html"

      prepare

      erb :top, :layout => :default
    end

  end
end
