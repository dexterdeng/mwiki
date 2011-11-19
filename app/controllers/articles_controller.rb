class ArticlesController < ApplicationController
  before_filter :authenticate_user!

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.where(:id => params[:id]).first
    redirect_to articles_path and return unless @article

    if @article and params[:v]
      @version = Version.find params[:v]
      @article = @version.reify
    end


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end


  # GET /articles/1
  # GET /articles/1.json
  def history
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.build(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created. #{undo_link}" }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])


    respond_to do |format|
      if @article.update_attributes(params[:article])
        undo_link = view_context.link_to("undo", revert_version_path(@article.versions.last), :method => :post)
        format.html { redirect_to @article, notice: "Article was successfully updated. #{undo_link}" }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, :notice => "Successfully destroyed article. #{undo_link}" }
      format.json { head :ok }
    end
  end

  def undo_link
     view_context.link_to("undo", revert_version_path(@article.versions.scoped.last), :method => :post)
  end
end
