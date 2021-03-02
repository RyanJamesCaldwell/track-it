class IssuesController < ApplicationController
  before_action :issue, only: [:show, :edit, :update, :destroy]
  before_action :verify_project_membership, only: [:create, :new, :edit, :update, :destroy]

  def create
    @issue = Issue.new(issue_params)
    if @issue.save
      flash[:success] = "Issue \"#{@issue.title}\" successfully created."
      redirect_to project_issue_path(@issue.project.id, @issue.id)
    else
      flash[:danger] = 'Issue could not be created.'
      render 'new'
    end
  end

  def new
    @project = Project.find(params[:project_id])
  end

  def show
  end

  def edit
  end

  def update
    if @issue.update(issue_params)
      flash[:success] = "Issue \"#{@issue.title}\" updated"
      redirect_to project_issue_path(@issue.project, @issue)
    else
      flash[:danger] = 'Issue could not be updated.'
      render 'edit'
    end
  end

  def destroy
    success_redirect = @issue.project
    if @issue.destroy
      flash[:success] = "Issue \"#{@issue.title}\" deleted."
      redirect_to success_redirect
    else
      flash[:danger] = "Issue \"#{@issue.title}\" could not be deleted."
      redirect_to 'edit'
    end
  end

  private

  def verify_project_membership
    project = @issue&.project || Project.find_by(id: params[:project_id]) || Project.find_by(id: params[:issue][:project_id])

    unless authenticate_user! && current_user.is_member_of?(project: project)
      flash[:danger] = 'You must be a member of the project to do that.'
      redirect_to project
    end
  end

  def issue
    @issue = Issue.find_by(id: params[:id])
    render_404 unless @issue
  end

  def issue_params
    params.require(:issue).permit(:title, :description, :project_id, :priority, :category, :state)
  end
end
