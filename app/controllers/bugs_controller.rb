# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bugs,  except: [:new, :create, :index, ]

  def new
    @project = Project.find(params[:project_id])
    @bug = Bug.new(project: @project)
    authorize @bug
  end

  def create
    @bug = current_user.bugs.build(bug_params)
    @project = Project.find(params[:project_id])
    @bug.project = @project
    authorize @bug
    if @bug.save
      redirect_to project_bugs_path(@project)
    else
      render 'new'
    end
  end

  def show
    authorize @bug
  end

  def index
    @bugs = policy_scope(Bug)
    @project = Project.find(params[:project_id])
    @devs = Dev.all
    @bugs = @bugs.where(project: @project)
    authorize Bug
  end

  def edit
    authorize @bug
  end

  def update
    authorize @bug
    if @bug.update(bug_params)
      redirect_to project_bug_path(@bug)
    else
      render 'edit'
    end
  end

  def assign_developer
    @project = Project.find(params[:project_id])
    authorize @bug
    @user = User.find(params[:user_id])

    if @user == current_user
      if @bug.update(assignee: @user)
        flash[:success] = 'Success'
      else
        flash[:alert] = 'Not Success'
      end
    end
    redirect_to project_bugs_path(@project)
  end

  def change_status
    @project = Project.find(params[:project_id])
    authorize @bug
    if @bug.update(status: 'Resolved')
      flash[:success] = 'Success'
    else
      flash[:alert] = 'Not Success'
   end
    redirect_to project_bugs_path(@project)
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :date, :bug_type, :status, :image)
  end 

  def set_bugs
    @bug = Bug.find(params[:id])
  end
end
