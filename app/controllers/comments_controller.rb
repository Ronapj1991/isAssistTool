class CommentsController < ApplicationController
    before_action :get_reported_incident
    before_action :set_comment, only: [:show, :edit, :update, :destroy]
    
    def index
       @comments = @reported_incident.comments
    end
    
    def show
    end
    
    def new
      @comment = @reported_incident.comments.build
    end
    
    def create
      @comment = @reported_incident.comments.build(comment_params)
      
      respond_to do |format|
        if @comment.save
          format.html { redirect_to [@reported_incident], notice: "Comment was successfully created" }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
    
    def edit
    end
    
    def update
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to [@reported_incident], notice: 'Comment was successfully updated.' }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
    
    def destroy
       @comment.destroy
       respond_to do |format|
         format.html { redirect_to [@reported_incident], notice: 'Comment was successfully deleted' }
         format.json { head :no_content }
       end
    end
    
    private
      
      def get_reported_incident
        @reported_incident = ReportedIncident.find(params[:reported_incident_id])
      end
    
      def set_comment
         @comment = @reported_incident.comments.find(params[:id]) 
      end
      
      def comment_params
         params.require(:comment).permit(:content, :reported_incident_id) 
      end
end
