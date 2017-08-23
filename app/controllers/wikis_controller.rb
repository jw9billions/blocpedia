class WikisController < ApplicationController
  before_action :require_sign_in, except: [:show, :index]
  before_action :authorize_user, except: [:index, :show, :new, :create]
  # before_action :authorize_user, only: [:edit, :destroy, :update]

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = wiki.build(wiki_params)
    @wiki.user = current_user
    if @wiki.save
      flash[:notice] = "Your wiki was saved!"
      @wiki.user.role = 'standard'
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
    params.require(:wiki).permit(:title, :body)
  end

  def authorize_user
    wiki = Wiki.find(params[:id])

    unless current_user == wiki.user
      flash[:alert] = "You must be an wiki owner to do that."
      redirect_to wiki
    end
  end

end
