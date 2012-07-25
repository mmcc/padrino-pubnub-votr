Admin.controllers :songs do

  get :index do
    @songs = Song.all
    render 'songs/index'
  end

  get :new do
    @song = Song.new
    render 'songs/new'
  end

  post :create do
    @song = Song.new(params[:song])
    if @song.save
      flash[:notice] = 'Song was successfully created.'
      redirect url(:songs, :edit, :id => @song.id)
    else
      render 'songs/new'
    end
  end

  get :edit, :with => :id do
    @song = Song.find(params[:id])
    render 'songs/edit'
  end

  put :update, :with => :id do
    @song = Song.find(params[:id])
    if @song.update_attributes(params[:song])
      flash[:notice] = 'Song was successfully updated.'
      redirect url(:songs, :edit, :id => @song.id)
    else
      render 'songs/edit'
    end
  end

  delete :destroy, :with => :id do
    song = Song.find(params[:id])
    if song.destroy
      flash[:notice] = 'Song was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Song!'
    end
    redirect url(:songs, :index)
  end
end
