class Link < ActiveRecord::Base
  validates :uri_path, uniqueness: {scope: :uri_host}

  def real_href
    scheme = "http"
    [scheme, "://", uri_host, uri_path].join
  end

end
