class WelcomeController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
  end

  def about
  end
end
