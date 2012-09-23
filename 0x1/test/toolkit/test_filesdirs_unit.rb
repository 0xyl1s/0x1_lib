# encoding: utf-8
require 'minitest/unit'
require 'minitest/autorun'

module X module Lib module Toolkit module Filesdirs

  class TestXLibToolkitFilesdirs < MiniTest::Unit::TestCase

    def setup
      require_relative '../../lib/toolkit/standard.rb'
      extend X::Lib::Toolkit::Standard
      @test_dir = Dir.pwd
      test_datadir_src = File.join(Dir.pwd,
                                   'test_filesdirs_unit_data/source')
      @test_datadir_tmp = File.join(Dir.pwd,
                                    'test_filesdirs_unit_data/_temp_erase')
      FileUtils.cp_r test_datadir_src, @test_datadir_tmp
      unless File.directory?(@test_datadir_tmp)
        puts "Error: @test_datadir_tmp is not a directory"+
             "(#{@test_datadir_tmp})."
        exit 1
      end
    end

    def teardown
      FileUtils.rm_rf @test_datadir_tmp
    end

    def test_x__rel_abs_path
      rel_path = 'test_filesdirs_unit_data/_temp_erase'
      tested_value = x__rel_abs_path(Dir.pwd, rel_path)
      target_value = File.absolute_path %x'(cd #{rel_path} ; pwd)'.chomp
      assert_equal target_value, tested_value
    end

    def test_x__abort_unless_rel_abs_path
      rel_path = './test_filesdirs_unit_data/_temp_erase'
      ref_dir = File.absolute_path %x'(cd #{rel_path} ; pwd)'.chomp

      tested_value = x__abort_unless_rel_abs_path(@test_dir, rel_path, :verb)
      assert_equal ref_dir, tested_value

      assert_raises SystemExit do
        bogus_dir = './bogus'
        x__abort_unless_rel_abs_path(@test_dir, bogus_dir)
      end

    end

    def test_x__file_read
      target_value = "gen\neral\n"
      tested_value = x__file_read("#{@test_datadir_tmp}/file1")
      assert_equal target_value, tested_value
    end

    def test_x__file_read_chomp
      target_value = "gen\neral"
      tested_value = x__file_read_chomp("#{@test_datadir_tmp}/file1")
      assert_equal target_value, tested_value
    end

  end

end end end end


# ____________________________________________________________________
# >>>>>  projet epiculture/ec1   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{{{
# Sources, Infos & Contact : http://www.epiculture.org
# Author: Pierre-Maël Crétinon
# License: GNU GPLv3 ( www.epiculture.org/ec1/LICENSE )
# Copyright: 2010-2012 Pierre-Maël Crétinon
# Sponsor: studio Helianova - http://studio.helianova.com
# ――――――――――――――――――――――――――――――――――――――#}}}
# vim:
