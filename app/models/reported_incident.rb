class ReportedIncident < ApplicationRecord
  require 'csv'
  has_many :comments, dependent: :destroy
    
  CSV_HEADER = %w[Incident-ID Resolution Reporter Sender Subject Resolved_by Themis_Confidence Comments]
  def self.as_csv
    #we start with a relation array where there "may" be multiple rows per incident
    #we combine all the rows for an incident to append all the comments in the end
    CSV.generate do |csv|
      csv << CSV_HEADER
      csv_row = nil #not yet working on a row
      
      all.each do |incident|
        if csv_row #if we're working on a row
          if incident.incident_id != csv_row[0]#if it's not the same incident
            csv << csv_row #add the old incident to the csv array
            csv_row = nil #start over for new incident
          end
        end
        
        if !csv_row
          #this is a new incident - so start a new row
          csv_row = [incident.incident_id, incident.resolution, incident.reported_by, incident.sender, incident.subject, incident.resolved_by, incident.themis_confidence]
        end
        
        if !incident.content
          #add to csv this incident immediately because it does not have a comment
          csv << csv_row
          csv_row = nil
          #we won't add anything to this row
        else #if it has a comment add the comment to the end of the row
          csv_row << incident.content
        end
        
      end
      
      if csv_row #if we have a line that wasn't added to the CSV array
        csv << csv_row
      end
    
    end
  end
    
end
