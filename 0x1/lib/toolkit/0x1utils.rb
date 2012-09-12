# encoding: utf-8

module X module Lib module Toolkit module Standard

  def x__
    "0xyl1s α --"
  end

  def x__digest_create(content, algorithm = 'sha256')
    OpenSSL::Digest.hexdigest(algorithm, content)
  end

  def x__abort_unless_digest_checked(s_digest_source, s_digest_checked,
                                     verbose=false)
    unless s_digest_checked == s_digest_source
      x__abort(verbose, "E: wrong digest (checked digest:\n"+
        "#{s_digest_checked} should be:\n#{s_digest_source})")
    end
  end

  def x__abort(verbose, message='0x1 abort...')
    if verbose
      puts message
    end
    abort
  end

  def x__random_string(i_number_of_characters=13, b_lowercase=false)
    unless x__is_an_integer?(i_number_of_characters)
      abort "E: i_number_of_characters must be an integer "+
        "(#{i_number_of_characters.class})"
    end
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
  # TODO: replacing on ec1 codebase all instances of ec1__random_name and
  # x__random_name by x__random_string
  alias :ec1__random_name :x__random_string
  alias :x__random_name :x__random_string

  # TODO: refactor with ternary operator
  def x__confirm(message='y(es) or no? ')
    print message
    e_confirm = STDIN.gets.chomp
    case e_confirm
    when /\Ay(es)?\z/i
      true
    else
      false
    end
  end
  alias :ec1__confirm :x__confirm

  def x__select_item(a_list, s_message='choice ? ')
    unless x__is_an_array?(a_list)
      abort "E: a_list must be an array (#{a_list.class})"
    end
    numbered_list = {}
    a_list.each_with_index do |item, index|
      numbered_list[index] = item
    end
    choice_valid = false
    until choice_valid
      puts "\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      numbered_list.each_pair do |key, value|
        # user friendly index starting with 1 instead of 0
        puts "#{key + 1} [#{value}]"
      end
      puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
      print "\n#{s_message}"
      choice_index_raw = gets.chomp
      if x__string_contain_only_numbers?(choice_index_raw)
        choice_only_number = true
      else
        puts "E: choice must be a number\n\n"
      end
      next unless choice_only_number
      choice_index = choice_index_raw.to_i - 1
      if (0..(a_list.size - 1)).include?(choice_index)
        choice_in_range = true
      else
        puts "E: Please select a number between 1 and #{a_list.size}\n\n"
      end
      next unless choice_in_range
      choice_valid = true if (choice_only_number and choice_in_range)
    end
    numbered_list[choice_index]
  end

  def x__abort_unless_extract_tarbz2(s_archive, s_extract_path, verbose=false)
    unless system "tar jxvf #{s_archive} -C #{s_extract_path}"
      abort "E: can't extract #{s_archive} on #{s_extract_path}"
    end
  end

  def x__rel_abs_path(s_base_path_abs, s_rel_path)
    File.join(File.dirname(s_base_path_abs), s_rel_path)
  end

  def x__abort_unless_rel_abs_path(s_base_path_abs, s_rel_path, verbose=false)
    path = x__rel_abs_path(s_base_path_abs, s_rel_path)
    unless x__is_a_file?(path)
      x__abort(verbose, "E: #{path} is not a valid path")
    end
    path
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
