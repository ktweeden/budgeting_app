require 'minitest/autorun'
require_relative '../models/utils'

class TestUtils < MiniTest::Test

  def test_as_money
    result = as_money(1000)
    assert_equal('10.00', result)
  end

end
