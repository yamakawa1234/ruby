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

require_relative '../helpers/scanner'

json    = {}
scanner = RubyVM::Scanner.new '../../../vm_opts.h'
grammer = %r'
    (?<ws>      \  ){0}
    (?<key>     \w+ ){0}
    (?<value>   0|1 ){0}
    (?<define>  \#define \g<ws>+ OPT_\g<key> \g<ws>+ \g<value> \g<ws>*\n ){0}
'mx

until scanner.eos? do
  if scanner.scan(/#{grammer} \g<define> /mx)
    json[scanner['key']] = ! scanner['value'].to_i.zero?
  else
    scanner.scan(/.*\n/)
  end
end

RubyVM::VmOptsH = json

return unless __FILE__ == $0
require 'json' or raise 'miniruby is NG'
JSON.dump RubyVM::VmOptsH, STDOUT
