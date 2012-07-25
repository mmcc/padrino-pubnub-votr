Admin.controllers :rounds do

  get :index do
    @rounds = Round.all
    render 'rounds/index'
  end

  get :new do
    @last = Round.last
    if @last.end_time.past?
      start_time = DateTime.now
    else
      start_time = @last.end_time + 1.seconds
    end
    @round = Round.new do |r|
      r.start_time = start_time
      r.end_time = start_time + 1.hours
    end
    render 'rounds/new'
  end

  post :create do
    @last = Round.last
    if params[:round][:start_time].to_time > @last.end_time && params[:round][:end_time].to_time > params[:round][:start_time]
      @round = Round.new(params[:round])
      if @round.save
        flash[:notice] = 'Round was successfully created.'
        redirect url(:rounds, :edit, :id => @round.id)
      end
    else
      flash[:error] = 'Start time cannot be before the round before ends and end time must be after start time.'
      redirect url(:rounds, :new)
    end
  end

  get :edit, :with => :id do
    @round = Round.find(params[:id])
    render 'rounds/edit'
  end

  put :update, :with => :id do
    @round = Round.find(params[:id])
    if @round.update_attributes(params[:round])
      flash[:notice] = 'Round was successfully updated.'
      redirect url(:rounds, :edit, :id => @round.id)
    else
      render 'rounds/edit'
    end
  end

  delete :destroy, :with => :id do
    round = Round.find(params[:id])
    if round.destroy
      flash[:notice] = 'Round was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Round!'
    end
    redirect url(:rounds, :index)
  end
end
