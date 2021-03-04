class AddAcceptRejectColumnsToMembershipRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :membership_requests, :accepted_at, :datetime
    add_column :membership_requests, :rejected_at, :datetime
    remove_index :membership_requests, name: 'index_project_membership_requests_on_user_and_project'
  end
end
