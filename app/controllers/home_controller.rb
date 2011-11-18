class HomeController < ApplicationController
  def index
  @articles = Article.all(:order => "id desc", :limit => 3)
  end

end
