class PagesController < ApplicationController
  def home
    @reported_incidents = ReportedIncident.all
  end
end
