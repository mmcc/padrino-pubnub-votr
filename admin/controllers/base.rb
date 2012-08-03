Admin.controllers :base do

  get :index, :map => "/" do
  	@current_round = Round.current.first
  	@upcoming_rounds = Round.where("start_time > ?", DateTime.now)
    render "base/index"
  end
end
