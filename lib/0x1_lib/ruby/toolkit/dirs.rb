# encoding: utf-8

module X module Lib module Toolkit module Filesdirs

  require 'fileutils'

  def x__is_a_dir?(s_dir)
    File.directory?(s_dir) ? true : false
  end

  def x__abort_unless_chdir(s_dir, verbose=true)
    x__abort_unless_is_a_dir(s_dir, verbose)
    unless Dir.chdir(s_dir)
      x__abort(verbose, "xE: can't chdir #{s_dir} ")
    end
  end

  def x__abort_if_is_a_dir(s_dir, verbose=true)
    if x__is_a_dir?(s_dir)
      x__abort(verbose, "xE: directory exists already:\n#{s_dir}")
    end
  end

  def x__abort_unless_is_a_dir(s_dir, verbose=true)
    unless x__is_a_dir?(s_dir)
      x__abort(verbose, "xE: can't access directory:\n#{s_dir}")
    end
  end

  def x__user_homedir()
    Dir.home
  end

  def x__dir_path_parse_into_array(s_dir_fullpath, verbose=true)
    x__abort_unless_is_a_string(s_dir_fullpath, verbose)
    unless s_dir_fullpath =~ /^\//
      x__abort(verbose, "xE: s_dir_fullpath must begin with a slash (#{s_dir_fullpath})")
    end
    dir_path_minus_leading_slash = s_dir_fullpath.sub(/^\//, '')
    dir_path_minus_leading_slash.split('/')
  end

  def x__dir_traverse_path_to_find_files(s_fullpath, s_file_relname, verbose=true)
    x__abort_unless_is_a_dir(s_fullpath, verbose)
    fullpath_stack = x__dir_path_parse_into_array(s_fullpath)
    found_file_fullpaths = []
    current_level_dir_stack = []
    loop do
      current_level_dir_stack << fullpath_stack.shift
      current_level_dir = File.join('/', current_level_dir_stack)
      current_level_entries = x__dir_list_non_recursive(current_level_dir)
      if current_level_entries.include?(s_file_relname)
        found_file_fullpath = File.join(current_level_dir, s_file_relname)
        if x__is_a_file?(found_file_fullpath)
          found_file_fullpaths << found_file_fullpath
        end
      end
      break if fullpath_stack.empty?
    end
    found_file_fullpaths.size > 0 ? found_file_fullpaths : false
  end

  def x__dir_list_non_recursive(s_directory, verbose=true)
    x__abort_unless_is_a_dir(s_directory, verbose)
    (Dir.entries(s_directory) - %w{ . ..}).sort
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
      x__abort(verbose, "xE: can't move #{s_origin_path} to #{s_target_path}")
    end
  end

  def x__dir_copy(s_sourcedirectory, s_destinationdirectory)
    unless x__is_a_dir?(s_sourcedirectory)
      abort "xE: Can't access directory: #{s_sourcedirectory}"
    end
    if x__is_a_dir?(s_destinationdirectory)
      abort "xE: destination_uri already exists: #{s_destinationdirectory}"
    end
    FileUtils.cp_r s_sourcedirectory, s_destinationdirectory
    unless x__is_a_dir?(s_destinationdirectory)
      abort "xE: can't copy directory: #{s_destinationdirectory}"
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
      x__abort(verbose, "xE: can't create directory #{s_dir}")
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
