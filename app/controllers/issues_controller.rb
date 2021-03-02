class IssuesController < ApplicationController
  def show
    @issue = Issue.find_by(id: params[:id])
  end
end
