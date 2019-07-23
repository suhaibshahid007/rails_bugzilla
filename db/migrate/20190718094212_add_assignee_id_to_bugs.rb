# frozen_string_literal: true

class AddAssigneeIdToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :assignee_id, :integer
  end
end
