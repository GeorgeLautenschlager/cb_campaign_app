class BriefingRoomController < ApplicationController
  def briefing
    
  end

  def roster
    if current_user
      redirect_to user_path(current_user)
    else
      redirect_to new_user_session_path
    end
  end

  def map

  end

  def stats

  end
end