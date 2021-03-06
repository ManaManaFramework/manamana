#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.9
# from Racc grammer file "".
#

require 'racc/parser.rb'

require 'manamana/rdsl/lexer'
require 'manamana/rdsl/nodes'

module ManaMana
  module RDSL
    class Parser < Racc::Parser

module_eval(<<'...end parser.y/module_eval...', 'parser.y', 63)
def parse(code, show_tokens=false)
  @tokens = Lexer.new.tokenize(code)
  puts @tokens.inspect if show_tokens
  do_parse
end

def next_token
  @tokens.shift
end
...end parser.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
     3,     8,     9,     8,     9,    18,     9,    10,     8,     3,
     4,     3,     8,    18,    23,     9,    18,    23 ]

racc_action_check = [
     3,     3,     3,     8,     8,     8,     9,     4,     5,     7,
     1,     0,    14,    15,    18,    21,    22,    23 ]

racc_action_pointer = [
     9,    10,   nil,    -2,     7,     5,   nil,     7,     0,     2,
   nil,   nil,   nil,   nil,     9,     8,   nil,   nil,     8,   nil,
   nil,    11,    11,    11,   nil,   nil,   nil ]

racc_action_default = [
    -1,   -24,    -2,    -3,   -24,    -4,    -5,    -6,    -9,   -17,
    27,    -7,    -8,   -10,   -11,   -13,   -14,   -19,   -24,   -18,
   -12,   -15,   -20,   -22,   -16,   -21,   -23 ]

racc_goto_table = [
     5,    14,     7,    16,    11,    15,    19,    13,     2,    22,
    21,     6,    25,    20,    26,    12,     1,   nil,    24 ]

racc_goto_check = [
     3,     5,     4,     6,     4,     3,     3,     4,     2,     8,
     6,     2,     7,     4,     8,     2,     1,   nil,     3 ]

racc_goto_pointer = [
   nil,    16,     8,    -3,    -1,    -7,    -5,   -10,    -9 ]

racc_goto_default = [
   nil,   nil,   nil,   nil,   nil,   nil,   nil,    17,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  0, 8, :_reduce_1,
  1, 8, :_reduce_2,
  1, 9, :_reduce_3,
  2, 9, :_reduce_4,
  2, 9, :_reduce_5,
  2, 9, :_reduce_6,
  3, 9, :_reduce_7,
  3, 9, :_reduce_8,
  1, 11, :_reduce_9,
  2, 11, :_reduce_10,
  2, 11, :_reduce_11,
  3, 11, :_reduce_12,
  1, 12, :_reduce_13,
  1, 12, :_reduce_14,
  2, 12, :_reduce_15,
  3, 12, :_reduce_16,
  1, 10, :_reduce_17,
  2, 10, :_reduce_18,
  1, 13, :_reduce_19,
  2, 14, :_reduce_20,
  3, 14, :_reduce_21,
  1, 15, :_reduce_22,
  2, 15, :_reduce_23 ]

racc_reduce_n = 24

racc_shift_n = 27

racc_token_table = {
  false => 0,
  :error => 1,
  :GROUP => 2,
  :REQUIREMENT => 3,
  :TEXT => 4,
  :ROW => 5,
  :CELL => 6 }

racc_nt_base = 7

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "GROUP",
  "REQUIREMENT",
  "TEXT",
  "ROW",
  "CELL",
  "$start",
  "Root",
  "Groups",
  "Text",
  "Requirements",
  "RequirementBody",
  "Table",
  "Rows",
  "Cells" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'parser.y', 10)
  def _reduce_1(val, _values, result)
     result = RootNode.new 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 11)
  def _reduce_2(val, _values, result)
     result = RootNode.new({}, val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 15)
  def _reduce_3(val, _values, result)
     result = [ GroupNode.new(val[0]) ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 16)
  def _reduce_4(val, _values, result)
     result = [ GroupNode.new(val[0]) ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 17)
  def _reduce_5(val, _values, result)
     result = [ GroupNode.new(val[0]) ] + val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 18)
  def _reduce_6(val, _values, result)
     result = [ GroupNode.new(val[0], val[1]) ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 19)
  def _reduce_7(val, _values, result)
     result = [ GroupNode.new(val[0], val[2]) ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 20)
  def _reduce_8(val, _values, result)
     result = [ GroupNode.new(val[0], val[1]) ] + val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 24)
  def _reduce_9(val, _values, result)
     result = [ RequirementNode.new(val[0]) ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 25)
  def _reduce_10(val, _values, result)
     result = [ RequirementNode.new(val[0]) ] + val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 26)
  def _reduce_11(val, _values, result)
     result = [ RequirementNode.new(val[0], val[1]) ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 27)
  def _reduce_12(val, _values, result)
     result = [ RequirementNode.new(val[0], val[1]) ] + val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 31)
  def _reduce_13(val, _values, result)
     result = val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 32)
  def _reduce_14(val, _values, result)
     result = val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 33)
  def _reduce_15(val, _values, result)
     result = val[0] + val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 34)
  def _reduce_16(val, _values, result)
     result = val[0] + val[1] + val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 38)
  def _reduce_17(val, _values, result)
     result = [] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 39)
  def _reduce_18(val, _values, result)
     result = [] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 43)
  def _reduce_19(val, _values, result)
     result = [ ExamplesNode.new({}, val[0]) ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 47)
  def _reduce_20(val, _values, result)
     result = [ RowNode.new({ value: val[1], offset: val[0][:offset] }) ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 48)
  def _reduce_21(val, _values, result)
     result = [ RowNode.new({ value: val[1], offset: val[0][:offset] }) ] + val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 52)
  def _reduce_22(val, _values, result)
     result = [ val[0][:value] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 53)
  def _reduce_23(val, _values, result)
     result = [ val[0][:value] ] + val[1] 
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

    end   # class Parser
    end   # module RDSL
  end   # module ManaMana
