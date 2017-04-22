#! /your/favourite/path/to/ruby
# -*- mode: ruby; coding: utf-8; indent-tabs-mode: nil; ruby-indent-level: 2 -*-
# -*- warn_indent: true; frozen_string_literal: true -*-
#
# Copyright (c) 2016 Urabe, Shyouhei.  All rights reserved.
#
# This file is  a part of the programming language  Ruby.  Permission is hereby
# granted, to  either redistribute and/or  modify this file, provided  that the
# conditions mentioned  in the  file COPYING  are met.   Consult that  file for
# details.

require 'pathname'
require 'strscan'

# This is  a tiny  wrapper of  StringScanner, to hold  the scan  pointer's line
# number and show that on parse error.
class RubyVM::Scanner
  attr_reader :__FILE__
  attr_reader :__LINE__

  def initialize path
    src       = Pathname.new __dir__
    src      += path
    @__LINE__ = 1
    @__FILE__ = src.realpath.to_path
    str       = src.read mode: 'rt:utf-8:utf-8'
    @scanner  = StringScanner.new str
  end

  def eos?
    @scanner.eos?
  end

  def scan re
    ret   = @__LINE__
    match = @scanner.scan re
    return unless match
    @__LINE__ += match.count "\n"
    return ret
  end

  def scan! re
    scan re or raise sprintf "parse error at line %d near: %p...", \
        @__LINE__, @scanner.peek(32)
  end

  def [] key
    return @scanner[key]
  end
end
