class wikiPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def update?
    user.present? || user.admin?
  end

  def edit
    user.present? || user.admin?
  end

  def destroy
    user.present? || user.admin?
  end
end
