class CreateMembershipRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :membership_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :membership_requests, [:user, :project], unique: true
  end
end
