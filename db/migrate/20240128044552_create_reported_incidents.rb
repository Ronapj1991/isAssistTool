class CreateReportedIncidents < ActiveRecord::Migration[7.1]
  def change
    create_table :reported_incidents do |t|
      t.datetime :reported
      t.string :sender
      t.string :subject
      t.string :reported_by
      t.string :resolution
      t.integer :themis_confidence
      t.string :resolved_by
      t.integer :incident_id

      t.timestamps
    end
  end
end
