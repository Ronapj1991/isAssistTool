class ReportedIncident < ApplicationRecord
  require 'csv'
  has_many :comments, dependent: :destroy
    
  CSV_HEADER = %w[Incident-ID Resolution Reporter Sender Subject Resolved_by Themis_Confidence Comments]
  def self.as_csv
    CSV.generate do |csv|
      csv << CSV_HEADER
      all.each do |incident|
        csv << [
          incident.incident_id, 
          incident.resolution, 
          incident.reported_by, 
          incident.sender, 
          incident.subject, 
          incident.resolved_by, 
          incident.themis_confidence,
          incident.comments.pluck(:content).join(', ')
        ]
      end
    end
  end
    
end
