# encoding: utf-8

module X module Lib module Toolkit module Filesdirs

  require 'fileutils'

  def x__is_a_dir?(s_dir)
    File.directory?(s_dir) ? true : false
  end

  def x__abort_unless_chdir(s_dir, verbose=true)
    x__abort_unless_is_a_dir(s_dir, verbose)
    unless Dir.chdir(s_dir)
      x__abort(verbose, "E: can't chdir #{s_dir} ")
    end
  end

  def x__abort_if_is_a_dir(s_dir, verbose=true)
    if x__is_a_dir?(s_dir)
      x__abort(verbose, "E: directory exists already:\n#{s_dir}")
    end
  end

  def x__abort_unless_is_a_dir(s_dir, verbose=true)
    unless x__is_a_dir?(s_dir)
      x__abort(verbose, "E: can't access directory:\n#{s_dir}")
    end
  end

  def x__user_homedir()
    Dir.home
  end

  def x__dir_path_parse_into_array(s_dir_fullpath, verbose=true)
    x__abort_unless_is_a_string(s_dir_fullpath, verbose)
    unless s_dir_fullpath =~ /^\//
      abort "E: s_dir_fullpath must begin with a slash (#{s_dir_fullpath})"
    end
    dir_path_minus_leading_slash = s_dir_fullpath.sub(/^\//, '')
    dir_path_minus_leading_slash.split('/')
  end

  def x__dir_list_non_recursive(s_directory, verbose=true)
    x__abort_unless_is_a_dir(s_directory, verbose)
    Dir.entries(s_directory) - %w{ . ..}
  end

  def x__dir_is_empty?(s_directory)
    x__dir_list_non_recursive(s_directory).size == 0 ? true : false
  end

  def x__dir_ls(directory_raw, filter_raw = '*')
    x__abort_unless_is_a_dir(directory_raw)
    # making sure directory path end with /
    unless directory_raw.match(/\/\Z/)
      directory = directory_raw << ('/')
    end
    Dir["#{directory}#{filter_raw}"]
  end

  def x__dir_list_recursive_raw(s_directory, verbose=true)
    x__abort_unless_is_a_dir(s_directory, verbose)
    Dir.chdir(s_directory)
    dir_list = []
    Dir.glob("**/{*,.*}").each do |file|
      # excluding . and .. subdirs
      next if file.match %r!\.\.?\z!
      dir_list << file
    end
    dir_list.sort.uniq
  end

  def x__dir_current
    puts Dir.pwd
  end

  def x__dir_move(initial_dir, new_dir)
    abort if x__is_a_dir?(new_dir)
    abort unless x__is_a_dir?(initial_dir)
    FileUtils.mv(initial_dir, new_dir)
  end

  def x__abort_unless_dir_move(s_origin_path, s_target_path, verbose=true)
    unless x__dir_move(s_origin_path, s_target_path)
      x__abort(verbose, "E: can't move #{s_origin_path} to #{s_target_path}")
    end
  end

  def x__dir_copy(s_sourcedirectory, s_destinationdirectory)
    unless x__is_a_dir?(s_sourcedirectory)
      abort "E: Can't access directory: #{s_sourcedirectory}"
    end
    if x__is_a_dir?(s_destinationdirectory)
      abort "E: destination_uri already exists: #{s_destinationdirectory}"
    end
    FileUtils.cp_r s_sourcedirectory, s_destinationdirectory
    unless x__is_a_dir?(s_destinationdirectory)
      abort "E: can't copy directory: #{s_destinationdirectory}"
    end
  end

  def x__dir_readable?(directory)
    abort if x__is_a_dir?(directory)
    File.readable?(directory) ? true : false
  end

  def x__dir_writable?(directory)
    abort if x__is_a_dir?(directory)
    File.writable?(directory) ? true : false
  end

  def x__mkdir(path)
    FileUtils.mkdir(path)
  end

  def x__mkdir_p(path)
    FileUtils.mkdir_p(path)
  end

  def x__abort_unless_mkdir_p(s_dir, verbose=true)
    unless x__mkdir_p(s_dir)
      x__abort(verbose, "E: can't create directory #{s_dir}")
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
