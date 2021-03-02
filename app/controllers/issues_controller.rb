class IssuesController < ApplicationController
  before_action :issue, only: [:show, :edit, :update, :destroy]

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
    @project_id = params[:project_id]
  end

  def show
  end

  def edit
  end

  def update
    if @issue.update(issue_params)
      flash[:success] = "Issue \"#{@issue.title}\" updated"
      redirect_to project_issue_path(@issue.project.id, @issue.id)
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

  def issue
    @issue = Issue.find_by(id: params[:id])
    render_404 unless @issue
  end

  def issue_params
    params.permit(:title, :description, :project_id, :priority, :category)
  end
end
