class TutorialsController < ApplicationController
  def show
    flash[:notice] = 'User must login to bookmark videos' if current_user.nil?
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
