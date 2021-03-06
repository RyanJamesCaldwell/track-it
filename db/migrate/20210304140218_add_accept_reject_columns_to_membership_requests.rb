class AddAcceptRejectColumnsToMembershipRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :membership_requests, :accepted_at, :datetime
    add_column :membership_requests, :rejected_at, :datetime
  end
end
