require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "GET /comments" do
    it "return customers index path" do
      comment = FactoryBot.create(:comment)
      get "/reported_incidents/#{ comment.reported_incident_id }/comments"
      
      expect(response).to have_http_status(200)
    end
  end
  describe "Show a comment" do
    it "A comment for the incident" do
      comment = FactoryBot.create(:comment)
      get "/reported_incidents/#{comment.reported_incident_id}/comments/#{comment.id}"
      
      expect(response).to have_http_status(200)
    end
  end
  describe "create comment path" do
    it "creates a comment" do
      incident = FactoryBot.create(:reported_incident)
      post "/reported_incidents/#{ incident.id }/comments", params: { comment: { content: "Word", 
                                                                                 reported_incident_id: incident.incident_id } }
      expect(response).to have_http_status(302)
    end
  end
  describe "/reported_incidents/:reported_incident_id/comments/:id" do
    it "updates the comment" do
      comment = FactoryBot.create(:comment)
      patch "/reported_incidents/#{comment.reported_incident_id}/comments/#{comment.id}", params: { comment: { content: "Changed Comment", 
                                                                                                               reported_incident_id: comment.reported_incident_id } }
      expect(response).to have_http_status(302)
    end
  end
  describe "/reported_incidents/:reported_incident_id/comments/:id" do
    it "deletes a comment" do
      comment = FactoryBot.create(:comment)
      delete "/reported_incidents/#{comment.reported_incident_id}/comments/#{comment.id}"
      expect(response).to have_http_status(302)
    end
  end
end
