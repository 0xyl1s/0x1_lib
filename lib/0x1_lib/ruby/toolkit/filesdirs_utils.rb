# encoding: utf-8

module X module Lib module Toolkit module Filesdirs

  require 'fileutils'

  def x__rel_abs_path(s_base_path_abs, s_rel_path)
    File.absolute_path File.join(s_base_path_abs, s_rel_path)
  end
  alias :x__filej :x__rel_abs_path

  def x__rel_home_path(s_rel_path)
    x__rel_abs_path(Dir.home, s_rel_path)
  end
  alias :x__filejhome :x__rel_home_path

  def x__rel_xsourcing_path(s_rel_path)
    x__rel_abs_path(File.join(Dir.home, '.0x1/00mu/00sourcing'), s_rel_path)
  end
  alias :x__filejsourcing :x__rel_xsourcing_path

  def x__abort_unless_rel_abs_path(s_base_path_abs, s_rel_path, verbose=true)
    path = x__rel_abs_path(s_base_path_abs, s_rel_path)
    unless x__is_a_file?(path)
      x__abort(verbose, "xE: #{path} is not a valid path")
    end
    path
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
