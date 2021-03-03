class MembershipRequestsController < ApplicationController
  before_action :authenticate_user!, :project
  before_action :verify_request_is_for_self, only: [:create]
  before_action :verify_project_admin, only: [:index, :destroy]

  def index
    @requests = MembershipRequest.where(project: @project)
  end

  def create
    @membership_request = MembershipRequest.new(membership_request_params)
    if @membership_request.save
      flash[:success] = "Your request to join #{@project.name} has been sent."
      redirect_to @project
    else
      flash[:danger] = "Your request to join the project couldn't be sent."
      redirect_to projects_path
    end
  end

  def destroy
    @request = MembershipRequest.find_by(id: membership_request_params[:id],
                                         project_id: membership_request_params[:project_id])
    if @request&.destroy
      flash[:success] = "Membership request was denied."
    else
      flash[:success] = "Membership request was accepted."
    end

    redirect_to project_membership_requests_path
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

  def membership_request_params
    puts "PARAMS======================= #{params}"
    params.permit(:id, :user_id, :project_id)
  end
end
