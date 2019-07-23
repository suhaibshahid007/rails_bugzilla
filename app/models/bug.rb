# frozen_string_literal: true

class Bug < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :assignee, optional: true, class_name: 'User', foreign_key: 'assignee_id'

  mount_uploader :image, ImageUploader
end
