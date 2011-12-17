# encoding: utf-8

module Ec1 module Lib module Toolkit module Standard
  TEMP='temp_debug'
  def ec1__time
    Time.new.strftime('%y-%m-%d_%h%m')
  end
  def ec1__dir_ls(directory_raw, filter_raw = '*')
    raise "#{directory_raw} is not a directory" unless File.directory?(directory_raw)
    # making sure directory path end with /
    directory = directory_raw << ('/') unless directory_raw.match(/\/\Z/)
    Dir["#{directory}#{filter_raw}"]
  end
  def ec1__dir_current
    puts Dir.pwd
  end
  def ec1__file_read(file)
    raise "Can't read #{file}" unless File.readable?(file)
    File.read(file)
  end
  def ec1__random_name(number_of_characters=13)
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
  #gets a file argument [string], and returns [array] of lines [string]
  def ec1__file_readlines(file)
    raise "Can't read #{file}" unless File.readable?(file)
    File.readlines(file)
  end
  #gets a file argument [string], and returns [array] of lines [string], excluding comments
  def ec1__file_readlines_minus_comments(file, comment_character = '#')
    ec1__file_readlines(file)
  end
  def ec1__confirm(message='y(es) or no? ')
    print message
    e_confirm = gets.chomp
    case e_confirm
    when /\Ay(es)?\z/i
      true
    else
      false
    end
  end
  def ec1__file_save_unsecured(e_file_content, e_file_name, e_file_mode='600')
    File.open(e_file_name, 'w') {|f| f.write(e_file_content) }
    File.chmod(e_file_mode.to_i(8), e_file_name)
  end
  def ec1__file_save_nl(e_file_content_raw, e_file_name, e_file_mode_raw=600)
    e_file_content = "#{e_file_content_raw}\n"
    ec1__file_save(e_file_content, e_file_name, e_file_mode_raw)
  end
  def ec1__file_save(e_file_content, e_file_name, e_file_mode_raw=600)
    require 'fileutils'
    e_file_mode = "0#{e_file_mode_raw.to_s}".to_i(8)
    raise "file #{e_file_name} exists already" if File.exist?(e_file_name) and not ec1__confirm("confirm overwriting #{e_file_name}? ")
    e_tempfile = "#{e_file_name}.ec1temp.#{ec1__random_name}"
    raise "can't write file #{e_tempfile}" unless File.open(e_tempfile, 'w') {|f| f.write(e_file_content) }
    raise "can't set file #{e_tempfile} mode to #{e_file_mode}" unless File.chmod(e_file_mode, e_tempfile)
    FileUtils.mv(e_tempfile, e_file_name)
  end
  def ec1__dir_copy(sourcedirectory, destination_uri)
    raise "Can't access directory: #{sourcedirectory}" unless File.directory?(sourcedirectory)
    raise "destination_uri already exists: #{destination_uri}" if File.directory?(destination_uri)
    destinationdirectory = File.dirname(destination_uri)
    ec1__directory_writable(destinationdirectory)
    FileUtils.cp_r sourcedirectory, destination_uri
  end
  def ec1__filename(fullpath)
    Pathname.new(fullpath).path
  end
  def ec1__
    puts "epiculture α --"
  end
  def ec1__check_file_exist(filename)
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
