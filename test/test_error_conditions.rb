require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestErrorConditions < MiniTest::Unit::TestCase

  def test_request_without_app_returns_a_request_fail_error
    assert_raises(Xplenty::API::Errors::RequestFailed) do
      raise Xplenty::API::Errors::RequestFailed.new('TODO', nil) # xplenty.jobs
    end
  end

end
