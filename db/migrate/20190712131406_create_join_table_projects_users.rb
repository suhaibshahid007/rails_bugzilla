# frozen_string_literal: true

class CreateJoinTableProjectsUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :projects, :users do |t|
      # t.index [:project_id, :user_id]
      # t.index [:user_id, :project_id]
    end
  end
end
