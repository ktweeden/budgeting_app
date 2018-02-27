require 'minitest/autorun'
require_relative '../models/utils'
require 'date'

class TestUtils < MiniTest::Test

  def test_to_pounds
    result = to_pounds(1000)
    assert_equal('10.00', result)
  end

  def test_to_pennies
    result = to_pennies('5.50')
    assert_equal('550', result)
  end

  def test_to_uk_date
    result = to_uk_date(Date.new(2001,2,3))
    assert_equal('03-02-2001', result)
  end

  def test_is_negative?
    result = is_negative(-5)
    assert_equal(true, result)
  end
end
