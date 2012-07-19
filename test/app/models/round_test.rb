require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class RoundTest < Test::Unit::TestCase
  context "Round Model" do
    should 'construct new instance' do
      @round = Round.new
      assert_not_nil @round
    end
  end
end
