class ReportedIncidentsCsvGenerator
   require 'csv'
   
   def initialize(incidents, fields:, **options)
      @incidents = incidents
      @options = options
      @fields = fields
   end
   
   def call
      CSV.generate(**@options) do |csv|
         csv << @fields
         @incidents.each do |incident|
             csv << incident.attributes.values_at(*@fields)
         end
      end
   end
   
   def self.call(incidents, fields: ReportedIncident.column_names, **options)
      new(incidents, fields: fields, **options).call 
   end
end