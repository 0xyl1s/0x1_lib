# encoding: utf-8
=begin
enabling this lib with:
require 'ec1/lib/toolkit/online.rb'
include Ec1::Lib::Toolkit::Online
=end

module Ec1 module Lib module Toolkit module Online
require 'open-uri'
require 'net/http'

DEBUG = true

def e__parse_uri(uri)
  URI.parse(uri)
end

def e__filename_from_parsed_uri(parsed_uri)
  parsed_uri.path.split('/').last
end

def e__read_uri_content(uri)
  open(uri).read
end

def e__http_response_code(parsed_uri)
  Net::HTTP.get_response(parsed_uri).code
end

def e__http_download(parsed_uri)
  parsed_uri.read
end

#def e__http_download(parsed_uri_raw)
  #parsed_uri = parsed_uri_raw.read
  #puts "e__http_download parsed_uri = #{parsed_uri}" if DEBUG
  #abort "Can't access #{parsed_uri}" unless e__http_response_code(parsed_uri) == '200'
  #Net::HTTP.start(parsed_uri.host) { |http|
    #http.get(parsed_uri.path).body
  #}
#end

def e__http_download_and_save(uri, save_basepath=nil)
  puts "e__http_download_and_save uri = #{uri}" if DEBUG
  puts "e__http_download_and_save save_basepath = #{save_basepath}" if DEBUG
  parsed_uri = e__parse_uri(uri)
  puts "e__http_download_and_save parsed_uri = #{parsed_uri}" if DEBUG
  downloaded_content = e__http_download(parsed_uri)
  filename_from_parsed_uri = e__filename_from_parsed_uri(parsed_uri)
  puts "e__http_download_and_save filename_from_parsed_uri = #{filename_from_parsed_uri}" if DEBUG
  if save_basepath.nil?
    save_basepath = e__dir_current 
  else
    abort "ERROR: can't access save_basepath #{save_basepath}" unless e__is_a_dir?(save_basepath)
  end
  save_path = "#{save_basepath}/#{filename_from_parsed_uri}"
  puts "e__http_download_and_save save_path = #{save_path}" if DEBUG
  e__file_save(downloaded_content, save_path)
end

# WARNING : dependancy to system util 'mail'
def e__email_send(to, from, subject, message)
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
