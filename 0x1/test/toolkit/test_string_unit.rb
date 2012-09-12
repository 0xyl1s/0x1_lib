# encoding: utf-8
require 'minitest/unit'
require 'minitest/autorun'

class Test0x1LibStrings < MiniTest::Unit::TestCase

  def setup
    require_relative '../../lib/toolkit/strings.rb'
    extend X::Lib::Toolkit::Standard
  end

  def teardown
  end

  def test_x__is_a_string?
    assert(x__is_a_string?('a'))
    refute(x__is_a_string?(2))
  end

end
