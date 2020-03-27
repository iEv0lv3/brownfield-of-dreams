class TutorialsController < ApplicationController
  def show
     if current_user == nil
      flash[:notice] = "User must login to bookmark videos"
    end
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
