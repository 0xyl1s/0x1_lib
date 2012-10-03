# encoding: utf-8

module X module Lib module Toolkit module Deprecated

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

  def ec1__file_read(file)
    abort "Can't read #{file}" unless x__file_readable?(file)
    File.read(file)
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
