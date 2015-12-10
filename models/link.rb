class Link < ActiveRecord::Base
  validates :uri_path, uniqueness: {scope: :uri_host}

  def real_href
    scheme = "http"
    head = [scheme, "://", uri_host].join
    path = File.join(head, uri_path.to_s)
    path
  end

end
