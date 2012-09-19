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
    #assert(x__is_an_integer?('i'), "letter i should not be detected as an integer")
    assert(x__is_an_integer?('i'))
  end

end
