require 'minitest/autorun'
require_relative '../models/utils'

class TestUtils < MiniTest::Test

  def test_to_pounds
    result = to_pounds(1000)
    assert_equal('10.00', result)
  end

  def test_to_pennies
    result = to_pennies('5.50')
    assert_equal('550', result)
  end
end
