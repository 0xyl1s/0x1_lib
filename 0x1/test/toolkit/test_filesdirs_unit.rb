# encoding: utf-8
require 'minitest/unit'
require 'minitest/autorun'

module X module Lib module Toolkit module Filesdirs

  class TestXLibToolkitFilesdirs < MiniTest::Unit::TestCase

    def setup
      require_relative '../../lib/toolkit/filesdirs.rb'
      extend X::Lib::Toolkit::Filesdirs
      @test_root_datadir = File.join(Dir.pwd, 'test_filesdirs_unit_data/')
      unless File.directory?(@test_root_datadir)
        puts "Error: @test_root_datadir is not a directory"+
             "(#{@test_root_datadir})."
        exit 1
      end
    end

    def teardown
    end

    def test_x__rel_abs_path
      rel_path = './test_filesdirs_unit_data'
      reference_dir = File.absolute_path %x'(cd #{rel_path} ; pwd)'.chomp
      tested_dir= x__rel_abs_path(@test_root_datadir, rel_path)
      assert_equal reference_dir, tested_dir
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
