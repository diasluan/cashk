#!/usr/bin/env ruby

require 'readline'
require 'parslet'

def main 
  loop do
    cmdline = Readline.readline("> ", true)
    tree = parse_cmdline(cmdline)
    p tree
  end
end

def parse_cmdline(cmdline)
  Parser.new.parse(cmdline)
end

class Parser < Parslet::Parser
  root :cmdline

  rule(:cmdline) { command }
  rule(:command) { arg.as(:arg).repeat(1).as(:command) }
  rule(:arg) { match[%q{^\s}].repeat(1) >> space?}

  rule(:space?) { space.maybe }
  rule(:space) { match[%q{\s}].repeat(1).ignore }
end

main
