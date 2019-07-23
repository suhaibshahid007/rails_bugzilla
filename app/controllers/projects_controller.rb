# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_projects,  except: [:new, :create, :index ]

  def new
    authorize Project.new
  end

  def create
    @project = current_user.projects.build(project_params)
    authorize @project
    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def index
    @projects = policy_scope(Project)
    authorize Project
  end

  def show
    authorize @project
  end

  def edit
    authorize @project
    @developers = Dev.all
    @users = User.all
    @qas = Qa.all
  end

  def update
    authorize @project
    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    authorize @project
    @project.destroy
    redirect_to projects_path
  end

  def add_user
    @user = User.find(params[:user_id])
    authorize @project 
    @project.users << @user
    redirect_to edit_project_path(@project)
  end

  def remove_user
    @user = User.find(params[:user_id])
    authorize @project 
    @project.users.delete(@user)
    redirect_to edit_project_path(@project)
  end

  private

  def project_params
    params.require(:project).permit(:title, :body)
  end

  def set_projects
    @project = Project.find(params[:id])
  end
end
