# encoding: utf-8
require 'minitest/unit'
require 'minitest/autorun'

class Test0x1LibNumbers < MiniTest::Unit::TestCase

  def setup
    require_relative '../../lib/toolkit/numbers.rb'
    extend X::Lib::Toolkit::Standard
  end

  def teardown
  end

  def test_x__is_an_integer?
    assert(x__is_an_integer?(2))
    refute(x__is_an_integer?('a'))
  end

end
