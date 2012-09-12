# encoding: utf-8

module X module Lib module Toolkit module Standard

  require 'json'

  def x__json_read(s_file, b_symbolized_names=false)
    JSON.parse(File.read(s_file), :symbolize_names => b_symbolized_names)
  end

  def ec1__file_read(file)
    abort "Can't read #{file}" unless x__file_readable?(file)
    File.read(file)
  end

  def x__file_read(file)
    File.read(file)
  end

  def x__file_read_chomp(file)
    x__file_read(file).chomp
  end

  # gets a file argument [string], and returns [array] of lines [string]
  def x__file_readlines(file)
    abort "Can't read #{file}" unless x__file_readable?(file)
    File.readlines(file)
  end
  alias :ec1__file_readlines :x__file_readlines

  # gets a file argument [string], and returns [array] of lines [string],
  # excluding comments
  def x__file_readlines_minus_comments(file, comment_character = '#')
    x__file_readlines(file)
  end

  def x__file_save_unsecured(e_file_content, e_file_name, e_file_mode='600')
    File.open(e_file_name, 'w') {|f| f.write(e_file_content) }
    File.chmod(e_file_mode, e_file_name)
  end
  alias :ec1__file_save_unsecured :x__file_save_unsecured

  def x__file_save_nl(e_file_content_raw, e_file_name, e_file_mode='600')
    e_file_content = "#{e_file_content_raw}\n"
    x__file_save(e_file_content, e_file_name, e_file_mode)
  end
  alias :ec1__file_save_nl :x__file_save_nl

  def x__tempfilename_generate(e_file_name)
    "#{e_file_name}.0x1temp.#{x__random_name}"
  end

  def x__file_save(e_file_content, e_file_name, e_file_mode='600')
    e_tempfile = x__tempfilename_generate(e_file_name)
    abort "file #{e_file_name} exists already" if x__is_a_file?(e_file_name)
    unless x__file_write(e_file_content, e_tempfile)
      abort "can't write file #{e_tempfile}"
    end
    unless x__file_chmod(e_tempfile, e_file_mode)
      abort "can't set file #{e_tempfile} mode to #{e_file_mode}"
    end
    unless x__file_move(e_tempfile, e_file_name)
      abort "can't overwrite #{e_tempfile} to #{e_file_name}"
    end
  end
  alias :ec1__file_save :x__file_save

  def x__file_overwrite(e_file_content, e_file_name)
    e_tempfile = x__tempfilename_generate(e_file_name)
    unless x__file_write(e_file_content, e_tempfile)
      abort "can't write file #{e_tempfile}"
    end
    unless x__file_move(e_tempfile, e_file_name)
      abort "can't overwrite #{e_tempfile} to #{e_file_name}"
    end
  end

  def x__file_write(content, filename)
    File.open(filename, 'w') {|f| f.write(content) }
  end

  def x__abort_unless_file_write(content, s_path, verbose=false)
    unless x__file_write(content, s_path)
      x__abort(verbose, "E: can't write file #{s_path}")
    end
  end

  def x__file_write_binary(content, filename)
    File.open(filename, 'wb') {|f| f.write(content) }
  end

  def x__file_puts(content, filename)
    File.open(filename, 'w') {|f| f.puts(content) }
  end

  def x__file_chmod(e_file_name, e_file_mode_raw='600')
    e_file_mode = "0#{e_file_mode_raw.to_s}".to_i(8)
    File.chmod(e_file_mode, e_file_name)
  end

  def x__file_move(initial_filename, new_filename)
    FileUtils.mv(initial_filename, new_filename)
  end

  def x__is_a_file?(s_file)
    File.exists?(s_file) ? true : false
  end

  def x__abort_unless_is_a_file(s_file, verbose=false)
    unless x__is_a_file?(s_file)
      x__abort(verbose, "E: #{s_file} is not a file")
    end
  end

  def x__is_a_regular_file?(s_file)
    File.file?(s_file) ? true : false
  end

  def x__file_absolute_path(s_file)
    File.absolute_path(s_file)
  end

  def x__file_type(s_file, verbose=false)
    File.ftype(s_file)
  end

  def x__file_readable?(file)
    File.readable?(file) ? true : false
  end

  def x__file_writable?(file)
    File.writable?(file) ? true : false
  end

  def x__is_a_dir?(s_dir)
    File.directory?(s_dir) ? true : false
  end

  def x__abort_unless_chdir(s_dir, verbose=false)
    x__abort_unless_is_a_dir(s_dir, verbose)
    unless Dir.chdir(s_dir)
      x__abort(verbose, "E: can't chdir #{s_dir} ")
    end
  end

  def x__abort_if_is_a_dir(s_dir, verbose=false)
    if x__is_a_dir?(s_dir)
      x__abort(verbose, "E: directory exists already:\n#{s_dir}")
    end
  end

  def x__abort_unless_is_a_dir(s_dir, verbose=false)
    unless x__is_a_dir?(s_dir)
      x__abort(verbose, "E: can't access directory:\n#{s_dir}")
    end
  end

  def x__user_homedir()
    Dir.home
  end

  def x__dir_list_non_recursive(s_directory, verbose=false)
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
  alias :ec1__dir_ls :x__dir_ls

  def x__dir_list_recursive_raw(s_directory, verbose=false)
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

  # possible file_types: :regular_files, :symbolic_links, :directories
  def x__files_list_filtered(a_filelist, a_file_types, verbose=false)
    x__abort_unless_is_an_array(a_filelist, verbose)
    filtered_list_raw = []
    a_filelist.each do |file|
      filetype = x__file_type(file, verbose=true)
      if filetype == "directory" and a_file_types.include?(:directories)
        filtered_list_raw << file
      elsif filetype == "file" and a_file_types.include?(:regular_files)
        filtered_list_raw << file
      elsif filetype == "link" and a_file_types.include?(:symbolic_links)
        filtered_list_raw << file
      end
    end
    filtered_list_raw.sort
  end

  def x__dir_current
    puts Dir.pwd
  end
  alias :ec1__dir_current :x__dir_current

  def x__dir_move(initial_dir, new_dir)
    abort if x__is_a_dir?(new_dir)
    abort unless x__is_a_dir?(initial_dir)
    FileUtils.mv(initial_dir, new_dir)
  end

  def x__abort_unless_dir_move(s_origin_path, s_target_path, verbose=false)
    unless x__dir_move(s_origin_path, s_target_path)
      x__abort(verbose, "E: can't move #{s_origin_path} to #{s_target_path}")
    end
  end

  def x__dir_copy(sourcedirectory, destination_uri)
    unless x__is_a_dir?(sourcedirectory)
      abort "Can't access directory: #{sourcedirectory}"
    end
    destinationdirectory = File.dirname(destination_uri)
    if x__is_a_dir?(destinationdirectory)
      abort "destination_uri already exists: #{destinationdirectory}"
    end
    unless x__dir_writable?(destinationdirectory)
      abort "directory #{destinationdirectory} isn't writable"
    end
    FileUtils.cp_r sourcedirectory, destinationdirectory
  end
  alias :ec1__dir_copy :x__dir_copy

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

  def x__abort_unless_mkdir_p(s_dir, verbose=false)
    unless x__mkdir_p(s_dir)
      x__abort(verbose, "E: can't create directory #{s_dir}")
    end
  end

  def x__is_a_symlink?(s_symlink)
    File.symlink?(s_symlink) ? true : false
  end

  def x__abort_if_is_a_symlink(s_symlink, verbose=false)
    if x__is_a_symlink?(s_symlink)
      x__abort(verbose, "E: #{s_symlink} is a symlink.")
    end
  end

  def x__symlink_target(s_symlink, verbose=false) 
    x__abort_unless_is_a_symlink(s_symlink, verbose)
    File.readlink(s_symlink)
  end

  def x__abort_unless_is_a_symlink(s_symlink, verbose=false)
    unless x__is_a_symlink?(s_symlink)
      x__abort(verbose, "E: #{s_symlink} is not a symlink.")
    end
  end

  def x__symlink_create(s_source_filename, s_target_symlink, verbose=false)
    x__abort_unless_is_a_file(s_source_filename, verbose)
    x__abort_if_is_a_symlink(s_target_symlink, verbose)
    File.symlink(s_source_filename, s_target_symlink)
  end

  def x__abort_unless_symlink_create(s_target_path, s_symlink, verbose=false)
    unless x__symlink_create(s_target_path, s_symlink, verbose)
      x__abort(verbose, "E: can't create symlink #{s_symlink} "+
               "pointing to #{s_target_path}")
    end
  end

  def x__symlink_delete(s_symlink, verbose=false)
    x__abort_unless_is_a_symlink(s_symlink, verbose)
    File.delete(s_symlink)
  end

  def x__abort_unless_symlink_delete(s_symlink, verbose=false)
    x__symlink_delete(s_symlink, verbose)
    if x__is_a_symlink?(s_symlink)
      x__abort(verbose, "E: can't delete symlink #{s_symlink}.")
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
