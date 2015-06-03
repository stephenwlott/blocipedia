class WelcomeController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def about
  end
end
