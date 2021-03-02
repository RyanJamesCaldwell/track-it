class ApplicationController < ActionController::Base
  def render_404
    render file: "#{Rails.root.join}/public/404.html", status: :not_found
  end
end
