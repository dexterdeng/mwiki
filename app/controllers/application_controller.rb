class ApplicationController < ActionController::Base
  protect_from_forgery

  def info_for_paper_trail
    {:ip => request.remote_ip, :user_agent => request.user_agent}
  end

end
