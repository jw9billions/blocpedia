class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:welcome, :about]

  def welcome
  end

  def about
  end
end
