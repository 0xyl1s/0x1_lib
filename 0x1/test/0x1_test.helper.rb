# encoding: utf-8

module X module Lib

  require 'minitest/autorun'

  class TestXLib < MiniTest::Unit::TestCase

    def setup
      @test_dir = Dir.pwd
    end

    def x__testdir_full(s__testdir_relative_path)
      @test_datadir_base_full = File.join(@test_dir, s__testdir_relative_path)
      @test_datadir_source = File.join(@test_datadir_base_full, "source")
      unless File.directory?(@test_datadir_source)
        abort "E: directory @test_datadir_source is not accessible "+
          "(#{@test_datadir_source})."
      end
      @test_datadir = File.join(@test_datadir_base_full, "_temp_erase")
    end

    def x__datadir_ini()
      if File.directory?(@test_datadir)
        abort "E: directory @test_datadir exists already (#{@test_datadir})."+
          " (and it should be deleted by the teardown method)"
      else
        FileUtils.cp_r @test_datadir_source, @test_datadir
      end
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
