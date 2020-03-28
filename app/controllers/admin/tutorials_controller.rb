class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @tutorial = Tutorial.create(tutorial_params)
    if @tutorial.save 
      video = @tutorial.videos.create(video_params)
      flash[:notice] = "Successfully created tutorial."
      redirect_to "/tutorials/#{@tutorial.id}"
    else
      flash[:notice] = "Please fill in all fields. " + @tutorial.errors.full_messages.to_sentence
      render :new
    end
  end

  def new
    @tutorial = Tutorial.new
  end


  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    if tutorial.destroy
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to admin_dashboard_path
  end

  private
  def tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail, :tag_list)
  end
  def video_params
    params.require(:video).permit(:title, :description, :thumbnail, :video_id)
  end
end
