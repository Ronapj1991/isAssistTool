class CsvImportService
    require 'csv'
    
    def initialize(file)
        @file = file
    end
    
    def import
      @count = 0
      file = File.open(@file)
      csv = CSV.parse(file, headers: true, col_sep: ',')
      csv.each do |row|
        incident_hash = {}
        incident_hash[:reported] = DateTime.strptime(row[0], '%Y-%m-%d %H:%M:%S')
        incident_hash[:resolved_by] = row['Resolved By']
        
        incident_hash[:incident_id] = row['Incident ID'][3..-1].to_i
        incident_hash[:sender] = row['Sender']
        incident_hash[:subject] = row['Subject']
        incident_hash[:reported_by] = row['Reported By']
        incident_hash[:resolution] = row['Resolution']
        incident_hash[:themis_confidence] = row['Themis Confidence'].to_i
        
        ReportedIncident.create!(incident_hash)
        @count += 1
      end
    end
    
    def number_imported_with_last_run
        @count
    end
end