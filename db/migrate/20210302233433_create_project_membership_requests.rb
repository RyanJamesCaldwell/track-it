class CreateProjectMembershipRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :project_membership_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :project_membership_requests, [:user, :project], unique: true
  end
end
