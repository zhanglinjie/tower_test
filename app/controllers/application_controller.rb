class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_member!

  helper_method :tm
  def tm(model_name)
    I18n.t("activerecord.models.#{model_name}")
  end

  def self.tm(model_name)
    I18n.t("activerecord.models.#{model_name}")
  end

  helper_method :current_team
  def current_team
    return @current_team if @current_team.present?
    return nil if current_member.blank?
    return nil if session[:current_team_id].blank?
    @current_team = current_member.teams.where(id: session[:current_team_id]).first
  end

  def set_current_team(team)
    @current_team = team
    session[:current_team_id] = team.try(:id)
  end
end
