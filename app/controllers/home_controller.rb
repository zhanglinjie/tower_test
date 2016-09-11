class HomeController < ApplicationController
  def launchpad
    if current_team.present?
      redirect_to [current_team, :projects]
    else
      redirect_to [:teams]
    end
  end
end