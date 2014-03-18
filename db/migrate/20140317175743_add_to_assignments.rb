class AddToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :name, :string
    add_column :assignments, :student_id, :integer
  end
end
