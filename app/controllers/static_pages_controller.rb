class StaticPagesController < ApplicationController
  def home
    @user = current_user
    determine_get_started_path
  end

  private

  def determine_get_started_path
    @get_started_destination = if user_signed_in?
                                 projects_path
                               else
                                 new_user_registration_path
                               end
  end
end
