# encoding: utf-8

module X module Lib
  require 'minitest/autorun'

  class TestXLib < MiniTest::Unit::TestCase

    def setup
      require_relative '../lib/toolkit/standard.rb'
      extend X::Lib::Toolkit::Standard
      @test_dir = Dir.pwd
    end

    def teardown
      FileUtils.rm_rf @test_datadir
    end

  end

end end

# ____________________________________________________________________
# >>>>>  projet epiculture/ec1   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{{{
# Sources, Infos & Contact : http://www.epiculture.org
# Author: Pierre-Maël Crétinon
# License: GNU GPLv3 ( www.epiculture.org/ec1/LICENSE )
# Copyright: 2010-2012 Pierre-Maël Crétinon
# Sponsor: studio Helianova - http://studio.helianova.com
# ――――――――――――――――――――――――――――――――――――――#}}}
# vim:
