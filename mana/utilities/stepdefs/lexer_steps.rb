# Add the gem's lib folder to the load path
$:.unshift File.expand_path("../../../../lib", __FILE__)
require 'manamana/rdsl/lexer'

step /^Tokenized ([\w\W]+) must equal ([\w\W]+)$/ do |code_block, tokens_str|

  output = ManaMana::RDSL::Lexer.new.tokenize(code_block)
  tokens = eval tokens_str
  output.must_equal tokens

end
