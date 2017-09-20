class CollaboratorsController < ApplicationController
  before_action :require_sign_in

  def create
    wiki = Wiki.find(params[:wiki_id])
    collaborator = current_user.collaborators.build(wiki: wiki)

    if collaborator.save
       flash[:notice] = " Wiki collaboratored."
    else
       flash[:alert] = "collaborating failed."
    end
    
    redirect_to wiki
  end

  def destroy
    wiki = Wiki.find(params[:wiki_id])
    favorite = current_user.favorites.find(params[:id])

    if collaborator.destroy
      flash[:notice] = "Wiki uncollaborated."
    else
      flash[:alert] = "Uncollaborating failed."
    end

    redirect_to [wiki]
  end

end
