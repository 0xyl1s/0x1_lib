# encoding: utf-8
=begin
enabling this lib with:
require 'ec1/lib/toolkit/standard.rb'
include Ec1::Lib::Toolkit::Standard
=end

module Ec1 module Lib module Toolkit module Standard
require 'fileutils'

  def e__datetime
    Time.new.strftime("%F_%H%M")
  end
  alias :ec1__time :e__datetime

  def e__datetime_sec
    Time.new.strftime("%F_%H%M%S")
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

  def ec1__file_read(file)
    abort "Can't read #{file}" unless e__file_readable?(file)
    File.read(file)
  end

  def e__file_read(file)
    File.read(file)
  end

  def e__string_contain_only_numbers?(string)
    abort "checked string-number must be a string..." unless string.is_a?(String)
    string =~ /^[\d]+$/ ? false : true
  end

  def e__random_name(number_of_characters=13)
    letters_lower = ('a'..'z').to_a
    letters_upper = ('A'..'Z').to_a
    numbers = (0..9).to_a.collect {|i| i.to_s}
    alphanumeric_upper_lower = letters_lower + letters_upper + numbers
    e_random_name = ''
    number_of_characters.times do
      e_random_name << alphanumeric_upper_lower[rand(alphanumeric_upper_lower.size)]
    end
    e_random_name
  end
  alias :ec1__random_name :e__random_name

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

  def e__file_save_unsecured(e_file_content, e_file_name, e_file_mode_raw='600')
    e_file_mode = "0#{e_file_mode_raw.to_s}".to_i(8)
    File.open(e_file_name, 'w') {|f| f.write(e_file_content) }
    File.chmod(e_file_mode.to_i(8), e_file_name)
  end
  alias :ec1__file_save_unsecured :e__file_save_unsecured

  def e__file_save_nl(e_file_content_raw, e_file_name, e_file_mode_raw='600')
    e_file_mode = "0#{e_file_mode_raw.to_s}".to_i(8)
    e_file_content = "#{e_file_content_raw}\n"
    e__file_save(e_file_content, e_file_name, e_file_mode)
  end
  alias :ec1__file_save_nl :e__file_save_nl

  def e__tempfilename_generate(e_file_name)
    "#{e_file_name}.ec1temp.#{e__random_name}"
  end

  def e__file_save(e_file_content, e_file_name, e_file_mode_raw='600')
    e_file_mode = "0#{e_file_mode_raw.to_s}".to_i(8)
    e_tempfile = e__tempfilename_generate(e_file_name)
    abort "file #{e_file_name} exists already" if e__is_a_file?(e_file_name)
    abort "can't write file #{e_tempfile}" unless e__file_write(e_tempfile, e_file_content)
    abort "can't set file #{e_tempfile} mode to #{e_file_mode}" unless e__file_chmod(e_tempfile, e_file_mode)
    abort "can't overwrite #{e_tempfile} to #{e_file_name}" unless e__file_move(e_tempfile, e_file_name)
  end
  alias :ec1__file_save :e__file_save

  def e__file_overwrite(e_file_content, e_file_name)
    e_tempfile = e__tempfilename_generate(e_file_name)
    abort "can't write file #{e_tempfile}" unless e__file_write(e_tempfile, e_file_content)
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
    File.chmod(e_file_mode, e_tempfile)
  end

  def e__file_move(initial_filename, new_filename)
    FileUtils.mv(initial_filename, new_filename)
  end

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

  def e__is_a_file?(file)
    File.exists?(file) ? true : false
  end

  def e__is_a_symlink?(file)
    File.symlink?(file) ? true : false
  end

  def e__is_a_dir?(directory)
    File.directory?(directory) ? true : false
  end

  def e__file_readable?(file)
    File.readable?(file) ? true : false
  end

  def e__file_writable?(file)
    File.writable?(file) ? true : false
  end

  def e__dir_readable?(directory)
    abort if e__is_a_dir?(directory)
    File.readable?(directory) ? true : false
  end

  def e__dir_writable?(directory)
    abort if e__is_a_dir?(directory)
    File.writable?(directory) ? true : false
  end

  def e__mkdir_p(path)
    FileUtils.mkdir_p(path)
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


# Project infos >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>># {{{
# Project: Epiculture
# Author: Pierre-Mael Cretinon
# Email: projects2011@3eclipses.com
# License: GNU GPLv3
#
# Notes:
#
# License details:
# <copyright/copyleft>
# Copyright 2010-2011 (c) Pierre-Mael CRETINON <copyleft@pierremael.net>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 
# </copyright/copyleft>
# Project infos <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<# }}}
#vim: foldmethod=marker
