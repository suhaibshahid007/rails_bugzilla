# frozen_string_literal: true

class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.date :date
      t.string :bug_type
      t.string :status

      t.timestamps
    end
  end
end
