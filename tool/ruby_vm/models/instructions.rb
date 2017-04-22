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

require_relative 'bare_instructions'
require_relative 'operands_unifications'
require_relative 'instructions_unifications'

# This array holds every instructions, including generated ones.
RubyVM::Instructions = RubyVM::BareInstructions.to_a + \
                       RubyVM::OperandsUnifications.to_a + \
                       RubyVM::InstructionsUnifications.to_a
RubyVM::Instructions.freeze
