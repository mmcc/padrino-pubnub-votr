require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class SongTest < Test::Unit::TestCase
  context "Song Model" do
    should 'construct new instance' do
      @song = Song.new
      assert_not_nil @song
    end
  end
end
