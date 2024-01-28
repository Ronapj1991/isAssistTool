require "application_system_test_case"

class ReportedIncidentsTest < ApplicationSystemTestCase
  setup do
    @reported_incident = reported_incidents(:one)
  end

  test "visiting the index" do
    visit reported_incidents_url
    assert_selector "h1", text: "Reported incidents"
  end

  test "should create reported incident" do
    visit reported_incidents_url
    click_on "New reported incident"

    fill_in "Incident", with: @reported_incident.incident_id
    fill_in "Reported", with: @reported_incident.reported
    fill_in "Reported by", with: @reported_incident.reported_by
    fill_in "Resolution", with: @reported_incident.resolution
    fill_in "Resolved by", with: @reported_incident.resolved_by
    fill_in "Sender", with: @reported_incident.sender
    fill_in "Subject", with: @reported_incident.subject
    fill_in "Themis confidence", with: @reported_incident.themis_confidence
    click_on "Create Reported incident"

    assert_text "Reported incident was successfully created"
    click_on "Back"
  end

  test "should update Reported incident" do
    visit reported_incident_url(@reported_incident)
    click_on "Edit this reported incident", match: :first

    fill_in "Incident", with: @reported_incident.incident_id
    fill_in "Reported", with: @reported_incident.reported
    fill_in "Reported by", with: @reported_incident.reported_by
    fill_in "Resolution", with: @reported_incident.resolution
    fill_in "Resolved by", with: @reported_incident.resolved_by
    fill_in "Sender", with: @reported_incident.sender
    fill_in "Subject", with: @reported_incident.subject
    fill_in "Themis confidence", with: @reported_incident.themis_confidence
    click_on "Update Reported incident"

    assert_text "Reported incident was successfully updated"
    click_on "Back"
  end

  test "should destroy Reported incident" do
    visit reported_incident_url(@reported_incident)
    click_on "Destroy this reported incident", match: :first

    assert_text "Reported incident was successfully destroyed"
  end
end
