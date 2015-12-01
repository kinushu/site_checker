require_relative '../lib/site_parser'

module Kpckara
  class App < Padrino::Application
    register ScssInitializer
    use ConnectionPoolManagement
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

  # トップページ
  get '/' do
    p url = params[:url] # "/Users/kinukawa/develop/helper/sitemap_creator/check.html"
    if url
        @res = SiteParser::parse_url(url)
    #    puts JSON.pretty_generate(res)
    end

    erb :top, :layout => :default
  end

  end
end
