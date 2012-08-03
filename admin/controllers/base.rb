Admin.controllers :base do

  get :index, :map => "/" do
  	@rounds = Round.scoped.includes(:songs).where("end_time > ?", DateTime.now)
  	@current_round = @rounds.current.first
  	@upcoming_rounds = @rounds.where("start_time > ?", DateTime.now)
    render "base/index"
  end
end
