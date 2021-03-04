class MembershipRequestsController < ApplicationController
  before_action :authenticate_user!, :project
  before_action :verify_request_is_for_self, only: [:create]
  before_action :verify_project_admin, only: [:index, :update]

  def index
    @requests = @project.open_membership_requests
  end

  def create
    @membership_request = MembershipRequest.new(user_id: params[:user_id],
                                                project_id: params[:project_id])
    if @membership_request.save
      flash[:success] = "Your request to join #{@project.name} has been sent."
      redirect_to @project
    else
      flash[:danger] = "Your request to join the project couldn't be sent."
      redirect_to projects_path
    end
  end

  def update
    @request = MembershipRequest.find_by(id: params[:request_id])
    request_handler = MembershipRequestHandler.new(@request)

    if params[:admin_action] == 'accept'
      request_handler.accept
    else
      request_handler.reject
    end

    redirect_to projects_path
  end

  private

  def verify_request_is_for_self
    unless current_user&.id == params[:user_id]&.to_i
      flash[:danger] = "You can only make project membership requests for yourself."
      redirect_to projects_path
    end
  end
  
  def verify_project_admin
    unless current_user&.is_admin_for?(project: @project)
      flash[:danger] = "You can't view membership requests unless you are a project admin."
      redirect_to @project
    end
  end

  def project
    @project = Project.find_by(id: params[:project_id])
  end
end
