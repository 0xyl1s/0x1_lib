# encoding: utf-8
# tested with ruby 1.9.3
=begin
enabling this lib with:
require '0x1/lib/toolkit/standard.rb'
include X::Lib::Toolkit::Standard
=end

# TODO: compartimentilize themes (file_operations, network_tools, ...)
module X module Lib module Toolkit module Standard
  require 'fileutils'

  ################## strings
  def x__user_homedir()
    File.expand_path("~")
  end

  def x__content_replace(s_content, s_search_regex, s_replace_value)
    s_content.sub(/#{s_search_regex}/, s_replace_value)
  end

  def x__is_a_string?(s_string)
    s_string.is_a?(String) ? true : false
  end

  def x__is_a_blank_string?(s_string)
    unless x__is_a_string?(s_string)
      abort "ERROR: provided s_string must be a string (#{s_string.class})"
    end
    s_string.empty? ? true : false
  end

  def x__string_contain_only_numbers?(s_string)
    unless x__is_a_string?(s_string)
      abort "checked string-number must be a string..."
    end
    s_string =~ /^[\d]+$/ ? true : false
  end

  # possible l_base values: :dec, :hex, :bin
  def x__integer_2_string(i_integer, l_base, verbose=false)
    unless x__is_an_integer?(i_integer)
      if verbose
        abort "E: you must supply an integer (#{i_integer})"
      else
        abort
      end
    end
    case l_base
    when :bin
      i_integer.to_s(2)
    when :hex
      i_integer.to_s(16)
    when :dec
      i_integer.to_s(10)
    end
  end

  # l_position can be :left :center :right
  def x__format_pad(s_string, l_position, i_length, s_pad, verbose=false)
    unless x__is_a_string?(s_string)
      if verbose
        abort "E: you must supply an integer (#{i_integer})"
      else
        abort
      end
    end
    case l_position
    when :left
      s_string.ljust(i_length, s_pad)
    when :center
      s_string.center(i_length, s_pad)
    when :right
      s_string.rjust(i_length, s_pad)
    else
      if verbose
        abort "E: l_position (#{l_position}) must be :left :center or :right"
      else
        abort
      end
    end
  end

  ################## numbers
  def x__is_an_integer?(i_integer)
    i_integer.is_a?(Integer) ? true : false
  end

  ################## collections
  def x__is_an_array?(a_array)
    a_array.is_a?(Array) ? true : false
  end

  def x__abort_unless_is_an_array(a_array, verbose=false)
    unless x__is_an_array?(a_array)
      x__abort(verbose, "E: #{a_array} is not an array")
    end
  end

  def x__array_value_exist?(array, value)
    abort unless x__is_an_array?(array)
    array.include?(value) ? true : false
  end

  ################## IO
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

  ################## datetime
  def x__datetime
    Time.new.strftime("%F_%H%M")
  end
  alias :ec1__time :x__datetime

  def x__datetime_sec
    Time.new.strftime("%F_%H%M.%S")
  end

  ################## processes

  ## was the last process well executed?
  #def x__lp_ok?()
    #$? == 0 ? true : false
  #end
  

  ################## 

  def x__digest_create(content, algorithm = 'sha256')
    OpenSSL::Digest.hexdigest(algorithm, content)
  end

  def x__abort_unless_digest_checked(s_digest_source, s_digest_checked,
                                     verbose=false)
    unless s_digest_checked == s_digest_source
      x__abort(verbose, "E: wrong digest (checked digest:\n"+
        "#{s_digest_checked} should be:\n#{s_digest_source})")
    end
  end

  ################## 0x1utils
  def x__
    puts "0xyl1s α --"
  end

  def x__abort(verbose, message='0x1 abort...')
    if verbose
      puts message
    end
    abort
  end

  def x__random_string(i_number_of_characters=13, b_lowercase=false)
    unless x__is_an_integer?(i_number_of_characters)
      abort "E: i_number_of_characters must be an integer "+
        "(#{i_number_of_characters.class})"
    end
    letters_lower = ('a'..'z').to_a
    letters_upper = ('A'..'Z').to_a
    numbers = (0..9).to_a.collect {|i| i.to_s}
    if b_lowercase
      characters_pool = numbers + letters_lower
    else
      characters_pool = numbers + letters_lower + letters_upper
    end
    e_random_name = ''
    i_number_of_characters.times do
      e_random_name << characters_pool[rand(characters_pool.size)]
    end
    e_random_name
  end
  # TODO: replacing on ec1 codebase all instances of ec1__random_name and
  # x__random_name by x__random_string
  alias :ec1__random_name :x__random_string
  alias :x__random_name :x__random_string

  # TODO: refactor with ternary operator
  def x__confirm(message='y(es) or no? ')
    print message
    e_confirm = STDIN.gets.chomp
    case e_confirm
    when /\Ay(es)?\z/i
      true
    else
      false
    end
  end
  alias :ec1__confirm :x__confirm

  def x__select_item(a_list, s_message='choice ? ')
    unless x__is_an_array?(a_list)
      abort "E: a_list must be an array (#{a_list.class})"
    end
    numbered_list = {}
    a_list.each_with_index do |item, index|
      numbered_list[index] = item
    end
    choice_valid = false
    until choice_valid
      puts "\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      numbered_list.each_pair do |key, value|
        # user friendly index starting with 1 instead of 0
        puts "#{key + 1} [#{value}]"
      end
      puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
      print "\n#{s_message}"
      choice_index_raw = gets.chomp
      if x__string_contain_only_numbers?(choice_index_raw)
        choice_only_number = true
      else
        puts "E: choice must be a number\n\n"
      end
      next unless choice_only_number
      choice_index = choice_index_raw.to_i - 1
      if (0..(a_list.size - 1)).include?(choice_index)
        choice_in_range = true
      else
        puts "E: Please select a number between 1 and #{a_list.size}\n\n"
      end
      next unless choice_in_range
      choice_valid = true if (choice_only_number and choice_in_range)
    end
    numbered_list[choice_index]
  end

  def x__abort_unless_extract_tarbz2(s_archive, s_extract_path, verbose=false)
    unless system "tar jxvf #{s_archive} -C #{s_extract_path}"
      abort "E: can't extract #{s_archive} on #{s_extract_path}"
    end
  end

  def x__rel_abs_path(s_base_path_abs, s_rel_path)
    File.join(File.dirname(s_base_path_abs), s_rel_path)
  end

  def x__abort_unless_rel_abs_path(s_base_path_abs, s_rel_path, verbose=false)
    path = x__rel_abs_path(s_base_path_abs, s_rel_path)
    unless x__is_a_file?(path)
      x__abort(verbose, "E: #{path} is not a valid path")
    end
    path
  end


  #_______________________________________________________________________
  ################## ☣ DEPRECATED ☣ ######################################
  #☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣

  def ec1__filename(fullpath)
    Pathname.new(fullpath).path
  end

  def x__check_file_exist(filename)
    File.exist?(filename)
  end

  def ec1__directory_writable(directory)
    unless File.writable?(directory)
      raise "directory #{directory} isn't writable"
    end
  end

  def ec1__new_file_writable(filename)
    unless File.exist?(filename)
      raise "file #{filename} doesn't exist or is inaccessible"
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
