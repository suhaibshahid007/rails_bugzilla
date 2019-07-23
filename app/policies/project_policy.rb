# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.where(id: user.projects.pluck(:id))
      #hello world
    end
  end

  def new?
    user.manager?
  end

  def create?
    new?
  end

  def index?
    user.manager? || user.qa? || user.developer?
  end

  def show?
    if user.manager?
      record.user == user
    else
      record.users.ids.include?user.id
    end

  end

  def edit?
    update?
  end

  def update?
    user.manager? and record.user == user
  end

  def destroy?
    user.manager?
  end

  def add_user?
    user.manager?
  end

  def remove_user?
    user.manager?
  end
end
