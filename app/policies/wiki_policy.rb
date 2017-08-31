class wikiPolicy < ApplicationPolicy
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

   def destroy?
     user.present? || user.admin?
   end

   def show?
     user.present? || user.admin?
   end

   class Scope
     attr_reader :user, :scope

     def initialize(user, scope)
        @user  = user
        @scope = scope
     end

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
   end
 end
