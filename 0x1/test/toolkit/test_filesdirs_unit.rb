# encoding: utf-8

module X module Lib module Toolkit module Filesdirs
  require_relative '../0x1_test.helper.rb'

  class TestXLibToolkitFilesdirs < MiniTest::Unit::TestCase

    def setup
      require_relative '../../lib/toolkit/standard.rb'
      extend X::Lib::Toolkit::Standard
      @test_dir = Dir.pwd
      test_datadir_src = File.join(Dir.pwd, 'test_filesdirs_unit_data/source')
      @test_datadir = File.join(Dir.pwd,
          'test_filesdirs_unit_data/_temp_erase')
      FileUtils.cp_r test_datadir_src, @test_datadir
      unless File.directory?(@test_datadir)
        puts "Error: @test_datadir is not a directory (#{@test_datadir})."
        exit 1
      end
    end

    def teardown
      FileUtils.rm_rf @test_datadir
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
      tested_value = x__file_read("#{@test_datadir}/file1")
      assert_equal target_value, tested_value
    end

    def test_x__file_read_chomp
      target_value = "gen\neral"
      tested_value = x__file_read_chomp("#{@test_datadir}/file1")
      assert_equal target_value, tested_value
    end

    def test_x__file_readlines
      target_value = ["gen\n", "eral\n"]
      tested_value = x__file_readlines("#{@test_datadir}/file1")
      assert_equal target_value, tested_value

      bogus_file = "/bogus/file"
      out, err = capture_io do
        assert_raises SystemExit do
          x__file_readlines(bogus_file, :verb)
        end
      end
      error_message = "Can't read #{bogus_file}\n"
      assert_equal error_message, out

    end

    def test_x__file_readlines_minus_comment_lines
      target_value = ["line1\n", "line2\n", "line3 with # inside\n",
        "    line4\n", "    line5 {\n", "    line6\n", "    }\n", "\n"]
      tested_value = x__file_readlines_minus_comment_lines(\
                       "#{@test_datadir}/file_with_comment_lines")
      assert_equal target_value, tested_value

      # test with customized comment_character, // instead of defalut #
      target_value2 = ["line1\n", "line2\n", "line3 with // inside\n",
        "    line4\n", "    line5 {\n", "    line6\n", "    }\n", "\n"]
      tested_value2 = x__file_readlines_minus_comment_lines(\
                       "#{@test_datadir}/file_with_comment_lines2", '//')
      assert_equal target_value2, tested_value2
    end

    def test_x__file_save_unsecured
      skip "untested yet..."
    end

    def test_x__file_save_nl
      skip "untested yet..."
    end

    def test_x__tempfilename_generate
      skip "untested yet..."
    end

    def test_x__file_save
      skip "untested yet..."
    end

    def test_x__file_overwrite
      skip "untested yet..."
    end

    def test_x__file_write
      skip "untested yet..."
    end

    def test_x__abort_unless_file_write
      skip "untested yet..."
    end

    def test_x__file_write_binary
      skip "untested yet..."
    end

    def test_x__file_puts
      skip "untested yet..."
    end

    def test_x__file_chmod
      skip "untested yet..."
    end

    def test_x__file_move
      skip "untested yet..."
    end

    def test_x__is_a_file?
      skip "untested yet..."
    end

    def test_x__abort_unless_is_a_file
      skip "untested yet..."
    end

    def test_x__is_a_regular_file?
      skip "untested yet..."
    end

    def test_x__file_absolute_path
      skip "untested yet..."
    end

    def test_x__file_type
      skip "untested yet..."
    end

    def test_x__file_readable?
      skip "untested yet..."
    end

    def test_x__file_writable?
      skip "untested yet..."
    end

    def test_x__is_a_dir?
      skip "untested yet..."
    end

    def test_x__abort_unless_chdir
      skip "untested yet..."
    end

    def test_x__abort_if_is_a_dir
      skip "untested yet..."
    end

    def test_x__abort_unless_is_a_dir
      skip "untested yet..."
    end

    def test_x__user_homedir
      skip "untested yet..."
    end

    def test_x__dir_list_non_recursive
      skip "untested yet..."
    end

    def test_x__dir_is_empty?
      skip "untested yet..."
    end

    def test_x__dir_ls
      skip "untested yet..."
    end

    def test_x__dir_list_recursive_raw
      skip "untested yet..."
    end

    def test_x__files_list_filtered
      skip "untested yet..."
    end

    def test_x__dir_current
      skip "untested yet..."
    end

    def test_x__dir_move
      skip "untested yet..."
    end

    def test_x__abort_unless_dir_move
      skip "untested yet..."
    end

    def test_x__dir_copy
      skip "untested yet..."
    end

    def test_x__dir_readable?
      skip "untested yet..."
    end

    def test_x__dir_writable?
      skip "untested yet..."
    end

    def test_x__mkdir
      skip "untested yet..."
    end

    def test_x__mkdir_p
      skip "untested yet..."
    end

    def test_x__abort_unless_mkdir_p
      skip "untested yet..."
    end

    def test_x__is_a_symlink?
      skip "untested yet..."
    end

    def test_x__abort_if_is_a_symlink
      skip "untested yet..."
    end

    def test_x__symlink_target
      skip "untested yet..."
    end

    def test_x__abort_unless_is_a_symlink
      skip "untested yet..."
    end

    def test_x__symlink_create
      skip "untested yet..."
    end

    def test_x__abort_unless_symlink_create
      skip "untested yet..."
    end

    def test_x__symlink_delete
      skip "untested yet..."
    end

    def test_x__abort_unless_symlink_delete
      skip "untested yet..."
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
