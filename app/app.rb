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

    # トップページ
    get '/' do
      @url = params[:url] # "/Users/kinukawa/develop/helper/sitemap_creator/check.html"
      if @url
          @res = SiteParser::parse_url(@url)
      #    puts JSON.pretty_generate(res)
        @uri_info = URI.parse(@url)
      end

      erb :top, :layout => :default
    end

  end
end
