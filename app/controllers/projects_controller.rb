class ProjectsController < ApplicationController
  before_action :verify_project_exists, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "Project '#{@project.name}' successfully created."
      redirect_to @project
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:success] = "Project '#{@project.name}' updated."
      redirect_to @project
    else
      flash[:danger] = "Project could not be updated."
      render 'edit'
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = "Project '#{@project.name}' deleted."
      redirect_to projects_path
    else
      redirect_to @project
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def verify_project_exists
    @project = Project.find_by(id: params[:id])
    render_404 unless @project
  end
end
