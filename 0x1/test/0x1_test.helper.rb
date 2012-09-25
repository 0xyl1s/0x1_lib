# encoding: utf-8

module X module Lib

  require 'minitest/autorun'

  class TestXLib < MiniTest::Unit::TestCase

    def setup
      @test_dir = Dir.pwd
    end

    def x__testdir_full(s__testdir_relative_path)
      @test_datadir_base_full = File.join(@test_dir, s__testdir_relative_path)
      unless File.directory?(@test_datadir_base_full)
        abort "E: directory @test_datadir_base_full is not accessible " +"(#{@test_datadir_base_full})."
      end
      @test_datadir_source = File.join(@test_datadir_base_full, "source")
      @test_datadir = File.join(@test_datadir_base_full, "_temp_erase")
    end

    def x__datadir_ini()
      FileUtils.cp_r @test_datadir_source, @test_datadir
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
