# encoding: utf-8
# tested with ruby 1.9.3
# TODO: ec1_lib should not be required based on an assumed (and uncontrollable) user's RUBYLIB path
=begin
enabling this lib with:
require 'ec1/lib/toolkit/standard.rb'
include Ec1::Lib::Toolkit::Standard
=end

module Ec1 module Lib module Toolkit module Standard
require 'fileutils'

  def e__user_homedir()
    File.expand_path("~")
  end

  def e__content_replace(s_content, s_search_regex, s_replace_value)
    s_content.sub(/#{s_search_regex}/, s_replace_value)
  end

  def e__random_string(i_number_of_characters=13, b_lowercase=false)
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
  # TODO: replacing on ec1 codebase all instances of ec1__random_name and e__random_name by e__random_string
  alias :ec1__random_name :e__random_string
  alias :e__random_name :e__random_string

  def e__string_contain_only_numbers?(s_string)
    abort "checked string-number must be a string..." unless s_string.is_a?(String)
    s_string =~ /^[\d]+$/ ? false : true
  end

  def e__datetime
    Time.new.strftime("%F_%H%M")
  end
  alias :ec1__time :e__datetime

  def e__datetime_sec
    Time.new.strftime("%F_%H%M.%S")
  end

  def e__is_an_array?(array)
    array.kind_of?(Array) ? true : false
  end

  def e__array_value_exist?(array, value)
    abort unless e__is_an_array?(array)
    array.include?(value) ? true : false
  end

  def ec1__file_read(file)
    abort "Can't read #{file}" unless e__file_readable?(file)
    File.read(file)
  end

  def e__file_read(file)
    File.read(file)
  end

  def e__file_read_chomp(file)
    e__file_read(file).chomp
  end

  #gets a file argument [string], and returns [array] of lines [string]
  def e__file_readlines(file)
    abort "Can't read #{file}" unless e__file_readable?(file)
    File.readlines(file)
  end
  alias :ec1__file_readlines :e__file_readlines

  #gets a file argument [string], and returns [array] of lines [string], excluding comments
  def e__file_readlines_minus_comments(file, comment_character = '#')
    e__file_readlines(file)
  end

  def e__confirm(message='y(es) or no? ')
    print message
    e_confirm = gets.chomp
    case e_confirm
    when /\Ay(es)?\z/i
      true
    else
      false
    end
  end
  alias :ec1__confirm :e__confirm

  def e__file_save_unsecured(e_file_content, e_file_name, e_file_mode='600')
    File.open(e_file_name, 'w') {|f| f.write(e_file_content) }
    File.chmod(e_file_mode, e_file_name)
  end
  alias :ec1__file_save_unsecured :e__file_save_unsecured

  def e__file_save_nl(e_file_content_raw, e_file_name, e_file_mode='600')
    e_file_content = "#{e_file_content_raw}\n"
    e__file_save(e_file_content, e_file_name, e_file_mode)
  end
  alias :ec1__file_save_nl :e__file_save_nl

  def e__tempfilename_generate(e_file_name)
    "#{e_file_name}.ec1temp.#{e__random_name}"
  end

  def e__file_save(e_file_content, e_file_name, e_file_mode='600')
    e_tempfile = e__tempfilename_generate(e_file_name)
    abort "file #{e_file_name} exists already" if e__is_a_file?(e_file_name)
    abort "can't write file #{e_tempfile}" unless e__file_write(e_file_content, e_tempfile)
    abort "can't set file #{e_tempfile} mode to #{e_file_mode}" unless e__file_chmod(e_tempfile, e_file_mode)
    abort "can't overwrite #{e_tempfile} to #{e_file_name}" unless e__file_move(e_tempfile, e_file_name)
  end
  alias :ec1__file_save :e__file_save

  def e__file_overwrite(e_file_content, e_file_name)
    e_tempfile = e__tempfilename_generate(e_file_name)
    abort "can't write file #{e_tempfile}" unless e__file_write(e_file_content, e_tempfile)
    abort "can't overwrite #{e_tempfile} to #{e_file_name}" unless e__file_move(e_tempfile, e_file_name)
  end

  def e__file_write(content, filename)
    File.open(filename, 'w') {|f| f.write(content) }
  end

  def e__file_write_binary(content, filename)
    File.open(filename, 'wb') {|f| f.write(content) }
  end

  def e__file_puts(content, filename)
    File.open(filename, 'w') {|f| f.puts(content) }
  end

  def e__file_chmod(e_file_name, e_file_mode_raw='600')
    e_file_mode = "0#{e_file_mode_raw.to_s}".to_i(8)
    File.chmod(e_file_mode, e_file_name)
  end

  def e__file_move(initial_filename, new_filename)
    FileUtils.mv(initial_filename, new_filename)
  end

  def e__is_a_file?(file)
    File.exists?(file) ? true : false
  end

  def e__file_readable?(file)
    File.readable?(file) ? true : false
  end

  def e__file_writable?(file)
    File.writable?(file) ? true : false
  end

  def e__is_a_dir?(directory)
    File.directory?(directory) ? true : false
  end

  def e__dir_list_non_recursive(s_directory)
    abort "ERROR: #{s_directory} is not a directory" unless e__is_a_dir?(s_directory)
    Dir.entries(s_directory) - %w{ . ..}
  end

  def e__dir_is_empty?(s_directory)
    e__dir_list_non_recursive(s_directory).size == 0 ? true : false
  end

  def e__dir_ls(directory_raw, filter_raw = '*')
    abort "#{directory_raw} is not a directory" unless e__is_a_dir?(directory_raw)
    # making sure directory path end with /
    directory = directory_raw << ('/') unless directory_raw.match(/\/\Z/)
    Dir["#{directory}#{filter_raw}"]
  end
  alias :ec1__dir_ls :e__dir_ls

  def e__dir_current
    puts Dir.pwd
  end
  alias :ec1__dir_current :e__dir_current

  def e__dir_move(initial_dir, new_dir)
    abort if e__is_a_dir?(new_dir)
    abort unless e__is_a_dir?(initial_dir)
    FileUtils.mv(initial_dir, new_dir)
  end

  def e__dir_copy(sourcedirectory, destination_uri)
    abort "Can't access directory: #{sourcedirectory}" unless e__is_a_dir?(sourcedirectory)
    destinationdirectory = File.dirname(destination_uri)
    abort "destination_uri already exists: #{destinationdirectory}" if e__is_a_dir?(destinationdirectory)
    abort "directory #{destinationdirectory} isn't writable" unless e__dir_writable?(destinationdirectory)
    FileUtils.cp_r sourcedirectory, destinationdirectory
  end
  alias :ec1__dir_copy :e__dir_copy

  def e__dir_readable?(directory)
    abort if e__is_a_dir?(directory)
    File.readable?(directory) ? true : false
  end

  def e__dir_writable?(directory)
    abort if e__is_a_dir?(directory)
    File.writable?(directory) ? true : false
  end

  def e__mkdir(path)
    FileUtils.mkdir(path)
  end

  def e__mkdir_p(path)
    FileUtils.mkdir_p(path)
  end

  def e__is_a_symlink?(file)
    File.symlink?(file) ? true : false
  end

  def e__symlink_create(original_filename, symlink_target)
    abort unless e__is_a_file?(original_filename)
    abort if e__is_a_symlink?(symlink_target)
    File.symlink(original_filename, symlink_target)
  end

  def e__digest_create(content, algorithm = 'sha256')
    OpenSSL::Digest.hexdigest(algorithm, content)
  end

  def ec1__
    puts "epiculture α --"
  end


#_______________________________________________________________________
################## ☣ DEPRECATED ☣ ######################################
#☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣☣

  def ec1__filename(fullpath)
    Pathname.new(fullpath).path
  end

  def e__check_file_exist(filename)
    File.exist?(filename)
  end

  def ec1__directory_writable(directory)
    raise "directory #{directory} isn't writable" unless File.writable?(directory)
  end

  def ec1__new_file_writable(filename)
    raise "file #{filename} doesn't exist or is inaccessible" unless File.exist?(filename)
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
