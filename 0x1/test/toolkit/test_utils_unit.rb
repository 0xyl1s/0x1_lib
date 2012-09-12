# encoding: utf-8
require 'minitest/unit'
require 'minitest/autorun'

class Test0x1Lib < MiniTest::Unit::TestCase
  def setup
    require_relative '../../lib/toolkit/standard.rb'
    extend X::Lib::Toolkit::Standard
  end

  def teardown
  end

  def test_x__
    assert_equal('0xyl1s α --', x__)
  end

  def test_x__user_homedir
    assert_equal(`echo -n $HOME`, x__user_homedir())
  end

  def test_x__is_a_string?
    assert(x__is_a_string?('a'))
    refute(x__is_a_string?(2))
  end

end
