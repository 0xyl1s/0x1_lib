# encoding: utf-8

module X module Lib module Toolkit module Filesdirs

  require 'fileutils'

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
