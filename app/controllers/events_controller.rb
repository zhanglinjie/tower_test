class EventsController < ApplicationController
  before_action :set_team
  def index
    @events = current_team.events.includes(:actor)
                                 .by_project(params[:by_project])
                                 .by_member(params[:by_member])
                                 .by_till_id(params[:till_id])
                                 .limit(50)
    respond_to do |format|
      format.html {
        if request.xhr?
          render :load_more, layout: false
        else
          render :index
        end
      }
    end
  end

  private
  def set_team
    @team = current_member.teams.find(params[:team_id])
    set_current_team(@team)
  end
end