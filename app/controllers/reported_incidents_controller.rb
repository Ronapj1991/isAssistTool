class ReportedIncidentsController < ApplicationController
  require 'csv'
  before_action :set_reported_incident, only: %i[ show edit update destroy ]
  before_action :set_incident_url_from_session, only: %i[ index spam ]
  
  def auto_incident_reponse
    @pagy, @reported_incidents = pagy((ReportedIncident.where(resolved_by: ["Themis", "External trusted source"])), items: 10)
    export_to_csv
  end
  
  def analyst
    @pagy, @reported_incidents = pagy((ReportedIncident.where.not(resolved_by: ["Themis", "External trusted source"])), items: 10)
    export_to_csv
  end
  
  def spam
    @pagy, @reported_incidents = pagy((ReportedIncident.where(resolution: "Spam")), items: 10)
    export_to_csv
  end
  
  def phishing
    @pagy, @reported_incidents = pagy((ReportedIncident.where(resolution: "Phishing")), items: 10)
    export_to_csv
  end
  
  def unclassified
    @pagy, @reported_incidents = pagy((ReportedIncident.where(resolution: "Unclassified")), items: 10)
    export_to_csv
  end
  
  def safe
    @pagy, @reported_incidents = pagy((ReportedIncident.where(resolution: "Safe")), items: 10)
    export_to_csv
  end
  
  def import
    if ReportedIncident.first
      return redirect_to root_path, alert: 'Please delete all data before uploading'
    end
    
    file = params[:file]

    #make sure that the right CSV is uploaded
    return redirect_to root_path, alert: 'You can only upload the Reported Incidents CSV' unless 
        file.original_filename.match(/Reported Incidents \(\d\d\d\d\-\d\d-\d\dT.*\).csv/)
    #Incident ID cannot be empty
    return redirect_to root_path, alert: 'Make sure that all Incident ID are not empty' unless 
           CSV.parse(file.open, headers: true).each do |row| 
             if row[7].nil?
               break
             end
           end
    #Make sure a CSV is selected
    return redirect_to root_path, alert: 'No file selected' unless file
    return redirect_to root_path, alert: 'Please select CSV file instead' unless file.content_type == 'text/csv'

    csvImportService = CsvImportService.new(file)
    csvImportService.import
    
    @incident_url = params[:incident_url]
    session[:incident_url] = @incident_url
    
    redirect_to reported_incidents_path, notice: "#{csvImportService.number_imported_with_last_run} incidents imported"
  end
  
  def clear
    ReportedIncident.destroy_all
    redirect_to root_path, notice: "All incidents are deleted"
  end

  # GET /reported_incidents or /reported_incidents.json
  def index
    if params[:query].present?
      @pagy, @reported_incidents = pagy((ReportedIncident.search_reported_incidents(params[:query])), items: 10)
    else
      @pagy, @reported_incidents = pagy((ReportedIncident.all), items: 10)
    end
    export_to_csv
  end

  # GET /reported_incidents/1 or /reported_incidents/1.json
  def show
  end

  # GET /reported_incidents/new
  def new
    @reported_incident = ReportedIncident.new
  end

  # GET /reported_incidents/1/edit
  def edit
  end

  # POST /reported_incidents or /reported_incidents.json
  def create
    @reported_incident = ReportedIncident.new(reported_incident_params)

    respond_to do |format|
      if @reported_incident.save
        format.html { redirect_to reported_incident_url(@reported_incident), notice: "Reported incident was successfully created." }
        format.json { render :show, status: :created, location: @reported_incident }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reported_incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reported_incidents/1 or /reported_incidents/1.json
  def update
    respond_to do |format|
      if @reported_incident.update(reported_incident_params)
        format.html { redirect_to reported_incident_url(@reported_incident), notice: "Reported incident was successfully updated." }
        format.json { render :show, status: :ok, location: @reported_incident }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reported_incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reported_incidents/1 or /reported_incidents/1.json
  def destroy
    @reported_incident.destroy!

    respond_to do |format|
      format.html { redirect_to reported_incidents_url, notice: "Reported incident was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def export_to_csv
      respond_to do |format|
        format.html 
        format.csv { send_data @reported_incidents.select("reported_incidents.*, comments.*")
                                                  .left_outer_joins(:comments)
                                                  .order(:incident_id).reverse_order
                                                  .as_csv, filename: "Updated-ReportedIncidents-#{Date.today}.csv" }
      end
    end
  
    def set_incident_url_from_session
      @incident_url = session[:incident_url]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_reported_incident
      @reported_incident = ReportedIncident.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reported_incident_params
      params.require(:reported_incident).permit(:reported, :sender, :subject, :reported_by, :resolution, :themis_confidence, :resolved_by, :incident_id)
    end
end
