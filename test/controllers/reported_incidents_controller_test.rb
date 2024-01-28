require "test_helper"

class ReportedIncidentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reported_incident = reported_incidents(:one)
  end

  test "should get index" do
    get reported_incidents_url
    assert_response :success
  end

  test "should get new" do
    get new_reported_incident_url
    assert_response :success
  end

  test "should create reported_incident" do
    assert_difference("ReportedIncident.count") do
      post reported_incidents_url, params: { reported_incident: { incident_id: @reported_incident.incident_id, reported: @reported_incident.reported, reported_by: @reported_incident.reported_by, resolution: @reported_incident.resolution, resolved_by: @reported_incident.resolved_by, sender: @reported_incident.sender, subject: @reported_incident.subject, themis_confidence: @reported_incident.themis_confidence } }
    end

    assert_redirected_to reported_incident_url(ReportedIncident.last)
  end

  test "should show reported_incident" do
    get reported_incident_url(@reported_incident)
    assert_response :success
  end

  test "should get edit" do
    get edit_reported_incident_url(@reported_incident)
    assert_response :success
  end

  test "should update reported_incident" do
    patch reported_incident_url(@reported_incident), params: { reported_incident: { incident_id: @reported_incident.incident_id, reported: @reported_incident.reported, reported_by: @reported_incident.reported_by, resolution: @reported_incident.resolution, resolved_by: @reported_incident.resolved_by, sender: @reported_incident.sender, subject: @reported_incident.subject, themis_confidence: @reported_incident.themis_confidence } }
    assert_redirected_to reported_incident_url(@reported_incident)
  end

  test "should destroy reported_incident" do
    assert_difference("ReportedIncident.count", -1) do
      delete reported_incident_url(@reported_incident)
    end

    assert_redirected_to reported_incidents_url
  end
end
