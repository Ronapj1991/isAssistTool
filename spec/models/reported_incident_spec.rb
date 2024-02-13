require 'rails_helper'

RSpec.describe ReportedIncident, type: :model do
    subject { ReportedIncident.new(reported: "2024-02-11 14:14:23.691810+00:00", 
                                   sender: "is_test100@yahoo.com", 
                                   subject: "invoice", 
                                   reported_by: "The Terminator", 
                                   resolution: "phishing", 
                                   themis_confidence: "50% - Phishing",
                                   resolved_by: "Mr. Analyst",
                                   incident_id: 11111111) }
    it "is valid with valid attributes" do
       expect(subject).to be_valid 
    end
    it "is not valid without incident_id" do
       expect(subject.incident_id).not_to be_nil
    end
end
