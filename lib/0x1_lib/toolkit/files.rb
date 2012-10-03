# encoding: utf-8

module X module Lib module Toolkit module Filesdirs

  require 'fileutils'

  def x__file_read(file)
    File.read(file)
  end

  def x__file_read_chomp(file)
    x__file_read(file).chomp
  end

  # gets a file argument [string], and returns [array] of lines [string]
  def x__file_readlines(file, verbose=false)
    unless x__file_readable?(file)
      x__abort(verbose, "Can't read #{file}")
    end
    File.readlines(file)
  end
  alias :ec1__file_readlines :x__file_readlines

  def x__file_readlines_minus_comment_lines(s_file, s_comment_character = '#')
    content_without_comments = []
    x__file_readlines(s_file).each do |line|
      xregex = %r"^\s*#{s_comment_character}"
      content_without_comments << line unless line =~ xregex
    end
    content_without_comments
  end

  def x__file_save_unsecured(e_file_content, e_file_name, e_file_mode='600')
    File.open(e_file_name, 'w') {|f| f.write(e_file_content) }
    File.chmod(e_file_mode, e_file_name)
  end
  alias :ec1__file_save_unsecured :x__file_save_unsecured

  def x__file_save_nl(e_file_content_raw, e_file_name, e_file_mode='600')
    e_file_content = "#{e_file_content_raw}\n"
    x__file_save(e_file_content, e_file_name, e_file_mode)
  end
  alias :ec1__file_save_nl :x__file_save_nl

  def x__tempfilename_generate(e_file_name)
    "#{e_file_name}.0x1temp.#{x__random_name}"
  end

  def x__file_save(e_file_content, e_file_name, e_file_mode='600')
    e_tempfile = x__tempfilename_generate(e_file_name)
    abort "file #{e_file_name} exists already" if x__is_a_file?(e_file_name)
    unless x__file_write(e_file_content, e_tempfile)
      abort "can't write file #{e_tempfile}"
    end
    unless x__file_chmod(e_tempfile, e_file_mode)
      abort "can't set file #{e_tempfile} mode to #{e_file_mode}"
    end
    unless x__file_move(e_tempfile, e_file_name)
      abort "can't overwrite #{e_tempfile} to #{e_file_name}"
    end
  end
  alias :ec1__file_save :x__file_save

  def x__file_overwrite(e_file_content, e_file_name)
    e_tempfile = x__tempfilename_generate(e_file_name)
    unless x__file_write(e_file_content, e_tempfile)
      abort "can't write file #{e_tempfile}"
    end
    unless x__file_move(e_tempfile, e_file_name)
      abort "can't overwrite #{e_tempfile} to #{e_file_name}"
    end
  end

  def x__file_write(content, filename)
    File.open(filename, 'w') {|f| f.write(content) }
  end

  def x__abort_unless_file_write(content, s_path, verbose=false)
    unless x__file_write(content, s_path)
      x__abort(verbose, "E: can't write file #{s_path}")
    end
  end

  def x__file_write_binary(content, filename)
    File.open(filename, 'wb') {|f| f.write(content) }
  end

  def x__file_puts(content, filename)
    File.open(filename, 'w') {|f| f.puts(content) }
  end

  def x__file_chmod(e_file_name, e_file_mode_raw='600')
    e_file_mode = "0#{e_file_mode_raw.to_s}".to_i(8)
    File.chmod(e_file_mode, e_file_name)
  end

  def x__file_move(initial_filename, new_filename)
    FileUtils.mv(initial_filename, new_filename)
  end

  def x__is_a_file?(s_file)
    File.exists?(s_file) ? true : false
  end

  def x__abort_unless_is_a_file(s_file, verbose=false)
    unless x__is_a_file?(s_file)
      x__abort(verbose, "E: #{s_file} is not a file")
    end
  end

  def x__is_a_regular_file?(s_file)
    File.file?(s_file) ? true : false
  end

  def x__file_absolute_path(s_file)
    File.absolute_path(s_file)
  end

  def x__file_type(s_file, verbose=false)
    File.ftype(s_file)
  end

  def x__file_readable?(file)
    File.readable?(file) ? true : false
  end

  def x__file_writable?(file)
    File.writable?(file) ? true : false
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
