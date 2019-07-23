# frozen_string_literal: true

class Dev < User
  has_and_belongs_to_many :projects, foreign_key: :user_id
  has_many :bugs, through: :projects
end
