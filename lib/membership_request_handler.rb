class MembershipRequestHandler
  def initialize(membership_request)
    raise 'Membership request cannot be nil' unless membership_request
    @request = membership_request
  end

  def accept
    MembershipRequest.transaction do
      ProjectRole.create!(user: @request.user, project: @request.project, role: 'standard')
      @request.update(accepted_at: Time.now)
    end
  end

  def reject
    @request.update(rejected_at: Time.now)
  end
end
