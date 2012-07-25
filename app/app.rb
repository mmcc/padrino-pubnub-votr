class Votr < Padrino::Application
  register SassInitializer
  use ActiveRecord::ConnectionAdapters::ConnectionManagement
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers

  enable :sessions

  PUBNUB = Pubnub.new(
    'pub-ac572c62-7762-4e2e-9afb-a7620048edb0',
    'sub-f5b1501e-a0fc-11e1-a6de-d1b91d67d2fc',
    'sec-MTU2ZDMxZTQtZDJhYS00NjM0LTk5NDEtNTU4OGE0M2Q3OGQ3',
    '',
    false
  )  

  get '/' do

    @round = Round.current.first
    p @round

    unless @round.end_time.past?

      difference = @round.end_time - DateTime.now.to_i
      @timer = difference
      @songs = @round.songs
      @msg = { :songs => @songs, :round => @round, :total_votes => @round.total_votes }.to_json

    end

    render 'index'
  end

  post '/vote', :provides => :json do
    @round = Round.includes(:songs).current.first

    unless @round.end_time.past?
      @songs = @round.songs
      @song = @songs.find(params[:id])
      @song.votes = @song.votes + 1
      @round.total_votes = @round.total_votes + 1

      @song.percentage = @song.votes.to_f / @round.total_votes.to_f

      if @song.save and @round.save
        @songs = Round.current.first.songs
        logger.info "Total votes: #{@round.total_votes}"
        testPublish = PUBNUB.publish({
          'channel' => 'votr-vote',
          'message' => { 'total_votes' => @round.total_votes, 'songs' => @songs },
          'callback' => lambda do |message|
            logger.info message
          end
        })

        render :success => true, :attributes => { 'round' => @round, 'song' => @song, 'songs' => @songs }

      else
        render :success => false, :attributes => {:message => "Unable to save your vote..."}
      end

    else
      render :success => false, :attributes => {:message => "The voting is already over."}
    end
  end

  ##
  # Caching support
  #
  # register Padrino::Cache
  # enable :caching
  #
  # You can customize caching store engines:
  #
  #   set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
  #   set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
  #   set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
  #   set :cache, Padrino::Cache::Store::Memory.new(50)
  #   set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
  #

  ##
  # Application configuration options
  #
  # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
  # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
  # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
  # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
  # set :public_folder, "foo/bar" # Location for static assets (default root/public)
  # set :reload, false            # Reload application files (default in development)
  # set :default_builder, "foo"   # Set a custom form builder (default 'StandardFormBuilder')
  # set :locale_path, "bar"       # Set path for I18n translations (default your_app/locales)
  # disable :sessions             # Disabled sessions by default (enable if needed)
  # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
  # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
  #

  ##
  # You can configure for a specified environment like:
  #
  #   configure :development do
  #     set :foo, :bar
  #     disable :asset_stamp # no asset timestamping for dev
  #   end
  #

  ##
  # You can manage errors like:
  #
  #   error 404 do
  #     render 'errors/404'
  #   end
  #
  #   error 505 do
  #     render 'errors/505'
  #   end
  #
end
