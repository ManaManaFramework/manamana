class ManaMana::TDSL::Parser

  token TEST_CASE
  token VARIABLES
  token PRECONDITIONS
  token CLEANUP
  token SCRIPT
  token LINE

  rule
    Root:
      /* empty array */           { result = RootNode.new }
    | TestCases                   { result = RootNode.new('', val[0]) }
    ;

    TestCases:
      TEST_CASE                        { result = [ TestCaseNode.new(val[0]) ] }
    | TEST_CASE TestCases              { result = [ TestCaseNode.new(val[0]) ] + val[1] }
    | TEST_CASE TestCaseBody           { result = [ TestCaseNode.new(val[0], val[1]) ] }
    | TEST_CASE TestCaseBody TestCases { result = [ TestCaseNode.new(val[0], val[1]) ] + val[2] }
    ;

    TestCaseBody:
      Variables
      Preconditions
      Cleanup
      Script                      { result = val[0].merge(val[1]).merge(val[2]).merge(val[3]) }
    ;

    Variables:
      /* No Variables Section */  { result = { :variables => VariablesNode.new } }
    | VARIABLES Assignments       { result = { :variables => VariablesNode.new('', val[1]) } }
    ;

    Assignments:
      LINE                        { result = [ AssignmentNode.new(val[0]) ] }
    | LINE Assignments            { result = [ AssignmentNode.new(val[0]) ] + val[1] }
    ;

    Preconditions:
      /* No Precon Section */     { result = { :preconditions => PreconditionsNode.new } }
    | PRECONDITIONS Lines         { result = { :preconditions => PreconditionsNode.new('', val[1]) } }
    ;

    Cleanup:
      /* No Cleanup Section */    { result = { :cleanup => CleanupNode.new } }
    | CLEANUP Lines               { result = { :cleanup => CleanupNode.new('', val[1]) } }
    ;

    Script:
      /* No Script Section */     { result = { :script => ScriptNode.new } }
    | SCRIPT Lines                { result = { :script => ScriptNode.new('', val[1]) } }
    ;

    Lines:
      LINE                        { result = [ StepNode.new(val[0]) ] }
    | LINE Lines                  { result = [ StepNode.new(val[0]) ] + val[1] }
    ;

end
---- header
require 'manamana/tdsl/lexer'
require 'manamana/tdsl/nodes'

---- inner
  def parse(code, show_tokens=false)
    @tokens = Lexer.new.tokenize(code)
    puts @tokens.inspect if show_tokens
    do_parse
  end

  def next_token
    @tokens.shift
  end