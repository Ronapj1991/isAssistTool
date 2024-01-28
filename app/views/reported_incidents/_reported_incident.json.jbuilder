json.extract! reported_incident, :id, :reported, :sender, :subject, :reported_by, :resolution, :themis_confidence, :resolved_by, :incident_id, :created_at, :updated_at
json.url reported_incident_url(reported_incident, format: :json)
