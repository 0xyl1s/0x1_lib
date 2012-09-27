# encoding: utf-8

module X module Lib module Toolkit module Collections

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
