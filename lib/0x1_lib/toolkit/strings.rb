# encoding: utf-8
# tested with ruby 1.9.3

module X module Lib module Toolkit module Strings

  def x__content_replace(s_content, s_search_regex, s_replace_value)
    s_content.sub(/#{s_search_regex}/, s_replace_value)
  end

  def x__is_a_string?(s_string)
    s_string.is_a?(String) ? true : false
  end

  def x__abort_unless_is_a_string(s_string, verbose=true)
    unless x__is_a_string?(s_string)
      x__abort(verbose, "E: s_string (#{s_string}) is not a string "+
               "(#{s_string.class})")
    end
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
