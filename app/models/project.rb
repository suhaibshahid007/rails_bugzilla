# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :users
  has_many :bugs, dependent: :destroy
end
