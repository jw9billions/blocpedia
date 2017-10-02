class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def index?
    user.present?
  end

   def update?
     user.present?
   end

   def edit?
     update? || user.admin?# user.present? || user.admin? || wiki.user_id == user.id || user.collaborator?(wiki)
   end

   def destroy?
     user.present? || user.admin?
   end

   def show?
     user.present? || user.admin? || user.premium?
   end

   class Scope
     attr_reader :user, :scope

     def initialize(user, scope)
        @user  = user
        @scope = scope
     end

     def resolve
       wikis = []
       if user.role == 'admin'
         wikis = scope.all
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if !wiki[:private] || wiki.owner == user || wiki.collaborators.include?(user)
              # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
             wikis << wiki
           end
         end
       else # standard
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if !wiki[:private] || wiki.collaborators.include?(user)
             wikis << wiki
           end
         end
       end
       wikis
     end

=begin
     def resolve
        if user.admin? || user.premium?
          @scope.all
        elsif @user.standard?
          @scope.where(private: false)
        else
          redirect_to "/users/sign_up"
          flash[:notice] = 'Please sign up to view wikis'
        end
     end
=end
   end
 end
