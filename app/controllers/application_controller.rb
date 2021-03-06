class ApplicationController < ActionController::Base
  def render_404
    render file: "#{Rails.root.join}/public/404.html", status: :not_found
  end

  def after_sign_in_path_for(resource)
    projects_path
  end
end
