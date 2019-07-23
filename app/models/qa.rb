# frozen_string_literal: true

class Qa < User
  has_and_belongs_to_many :projects, foreign_key: :user_id
  has_many :bugs, foreign_key: :user_id
end
