class RenameProjectMembershipRequests < ActiveRecord::Migration[6.0]
  def change
    rename_table :project_membership_requests, :membership_requests
  end
end
