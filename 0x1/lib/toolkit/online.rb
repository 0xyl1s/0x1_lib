# encoding: utf-8
=begin
enabling this lib with:
require '0x1/lib/toolkit/online.rb'
include X::Lib::Toolkit::Online
=end

module X module Lib module Toolkit module Online
  require 'open-uri'
  require 'net/http'

  DEBUG = false

  # TODO: implementing a ruby solution instead of external command
  def x__service_online?(host, port, delay='8')
    check_command = "netcat -w #{delay} -z #{host} #{port}"
    system check_command
    $? == 0 ? true : false
  end

  def x__parse_uri(uri)
    URI.parse(uri)
  end

  def x__filename_from_parsed_uri(parsed_uri)
    parsed_uri.path.split('/').last
  end

  def x__read_uri_content(uri)
    open(uri).read
  end

  def x__http_response_code(parsed_uri)
    Net::HTTP.get_response(parsed_uri).code
  end

  def x__http_download(parsed_uri)
    parsed_uri.read
  end

  #def x__http_download(parsed_uri_raw)
  #parsed_uri = parsed_uri_raw.read
  #puts "x__http_download parsed_uri = #{parsed_uri}" if DEBUG
  #abort "Can't access #{parsed_uri}" unless x__http_response_code(parsed_uri) == '200'
  #Net::HTTP.start(parsed_uri.host) { |http|
  #http.get(parsed_uri.path).body
  #}
  #end

  def x__http_download_and_save(uri, save_basepath=nil)
    puts "x__http_download_and_save uri = #{uri}" if DEBUG
    puts "x__http_download_and_save save_basepath = #{save_basepath}" if DEBUG
    parsed_uri = x__parse_uri(uri)
    puts "x__http_download_and_save parsed_uri = #{parsed_uri}" if DEBUG
    downloaded_content = x__http_download(parsed_uri)
    filename_from_parsed_uri = x__filename_from_parsed_uri(parsed_uri)
    puts "x__http_download_and_save filename_from_parsed_uri = #{filename_from_parsed_uri}" if DEBUG
    if save_basepath.nil?
      save_basepath = x__dir_current 
    else
      abort "ERROR: can't access save_basepath #{save_basepath}" unless x__is_a_dir?(save_basepath)
    end
    save_path = "#{save_basepath}/#{filename_from_parsed_uri}"
    puts "x__http_download_and_save save_path = #{save_path}" if DEBUG
    x__file_save(downloaded_content, save_path)
  end

  # WARNING : dependancy to system util 'mail'
  def x__email_send(to, from, subject, message)
    system "echo \"#{message}\" | mail \"#{to}\" -s \"#{subject}\" -a FROM:\"#{from}\""
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
