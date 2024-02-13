require 'rails_helper'

RSpec.describe "ReportedIncidents", type: :request do
  describe "GET /reported_incidents" do
    it "works! (now write some real specs)" do
      get reported_incidents_path
      expect(response).to have_http_status(200)
    end
  end
  describe "get reported_incident" do
    it "renders show template" do
      incident = FactoryBot.create(:reported_incident)
      get reported_incident_path(id: incident.id)
      expect(response).to have_http_status(200)
    end
  end
  describe "create an incident" do
    it "creates an incident for if incident ID is present" do
      post "/reported_incidents/", params: { reported_incident: { id: 15, 
                                                                 reported: "Thu, 25 Sep 2014 00:00:00.000000000 UTC +00:00", 
                                                                 sender: "cecile@hill.example", 
                                                                 subject: "Butterscotch", 
                                                                 reported_by: "Dallas Dare", 
                                                                 resolution: "Safe", 
                                                                 themis_confidence: 90, 
                                                                 resolved_by: "Themis", 
                                                                 incident_id: 34394863} }
      expect(response).to have_http_status(302)
    end
  end
  describe "update incident" do
    it "updates incident resolution" do
      incident = FactoryBot.create(:reported_incident)
      patch "/reported_incidents/#{incident.id}", params: { reported_incident: { id: 15, 
                                                                                 reported: "Thu, 25 Sep 2014 00:00:00.000000000 UTC +00:00", 
                                                                                 sender: "cecile@hill.example", 
                                                                                 subject: "Butterscotch", 
                                                                                 reported_by: "Dallas Dare", 
                                                                                 resolution: "Safe", 
                                                                                 themis_confidence: 90, 
                                                                                 resolved_by: "Themis", 
                                                                                 incident_id: 34394863} }
      expect(response).to have_http_status(302)
    end
  end
  describe "delete an incident" do
    it "deletes the selected incident" do
      incident = FactoryBot.create(:reported_incident)
      incident.delete
      expect(get reported_incident_path(id: incident.id)).to eql(404)
    end
    it "deletes all the incidents" do
      delete clear_reported_incidents_path
      expect(response).to have_http_status(302)
    end
  end
end
