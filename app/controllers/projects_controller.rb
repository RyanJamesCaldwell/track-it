class ProjectsController < ApplicationController
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
    @project = Project.find_by(id: params[:id])
  end

  def edit
    @project = Project.find_by(id: params[:id])
  end

  def update
    @project = Project.find_by(id: params[:id])
    if @project.update(project_params)
      flash[:success] = "Project '#{@project.name}' updated."
      redirect_to @project
    else
      flash[:danger] = "Project '#{@project.name}' could not be updated."
      render 'edit'
    end
  end

  def destroy
    @project = Project.find_by(id: params[:id])
    if @project.destroy
      flash[:success] = "Project '#{@project.name}' deleted."
      redirect_to root_url
    else
      redirect_to @project
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
