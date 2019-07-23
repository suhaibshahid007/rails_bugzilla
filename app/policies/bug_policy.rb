# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.where(id: user.bugs.pluck(:id))
    end
  end

  def new?
    (user.type == 'Qa') && record.project.users.include?(user)
  end

  def assign_developer?
    record.assignee.nil?
  end

  def create?
    new?
  end

  def show?
    user.qa? || user.developer?
  end

  def index?
    user.qa? || user.developer?
  end

  def edit?
    update?
  end

  def update?
    user.developer?
  end

  def change_status?
    user.developer?
  end
end
