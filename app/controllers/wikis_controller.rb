class WikisController < ApplicationController
  #before_action :require_sign_in, except: [:show, :index]
  before_action :authorize_user, except: [:index, :show, :new, :create]

  def index
    authorize(Wiki)
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki[:private] && current_user.standard?
      flash[:notice] = "Please upgrade to premium user to view this Wiki."
      redirect_to wikis_path
    end
  end

  def new
    @wiki = Wiki.new
  end

  def create

    #@wiki = wikis.build(wiki_params)
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    if @wiki.save
      flash[:notice] = "Your wiki was saved!"
      redirect_to @wiki
    else
      flash.now[:alert] = "There is an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was updated"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again"
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  def authorize_user
    wiki = Wiki.find(params[:id])

    unless current_user == wiki.user
      flash[:alert] = "You must be an wiki owner to do that."
      redirect_to wiki
    end
  end

end
