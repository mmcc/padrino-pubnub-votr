class Votr < Padrino::Application
  register SassInitializer
  use ActiveRecord::ConnectionAdapters::ConnectionManagement
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers

  enable :sessions

  PUBNUB = Pubnub.new(
    'PUBLISH-KEY',
    'SUBSCRIBE-KEY',
    '',
    '',
    false
  )

  get '/' do

    @round = Round.current.first

    unless @round.blank? || @round.end_time.past?

      @timer = @round.end_time - DateTime.now.to_i
      @songs = @round.songs.order("artist")
      @msg = { :songs => @songs, :round => @round, :total_votes => @round.total_votes }.to_json

    end

    render 'index'
  end

  post '/vote', :provides => :json do
    @round = Round.includes(:songs).current.first

    unless @round.end_time.past?
      @songs = @round.songs.order("artist")
      @song = @songs.find(params[:id])
      @song.votes = @song.votes + 1
      @round.total_votes = @round.total_votes + 1

      @song.percentage = @song.votes.to_f / @round.total_votes.to_f

      if @song.save and @round.save
        @songs = Round.current.first.songs
        logger.info "Total votes: #{@round.total_votes}"

        publish = PUBNUB.publish({
          'channel' => 'votr-vote',
          'message' => { 'total_votes' => @round.total_votes, 'songs' => @songs },
          'callback' => lambda do |message|
            logger.info message
          end
        })

        render :success => true, :attributes => { 'round' => @round, 'songs' => @songs }

      else
        render :success => false, :attributes => {:message => "Unable to save your vote..."}
      end

    else
      render :success => false, :attributes => {:message => "The voting is already over."}
    end
  end
end
