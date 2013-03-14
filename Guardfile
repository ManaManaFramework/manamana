# More info at https://github.com/guard/guard#readme

guard 'minitest' do
  watch(%r|^lib/manamana\.rb|)                { "test" }
  watch(%r|^lib/(.*)/(.*)\.rb|)               { |m| "test/lib/#{m[1]}/#{m[2]}_test.rb" }

  watch(%r|^test/test_helper\.rb|)            { "test" }
  watch(%r|^test/lib/.*/.*_test\.rb|)
end

guard 'rake', :task => 'rdsl:compile_lexer' do
  watch %r{^src/rdsl/lexer\.rl$}
end

guard 'rake', :task => 'rdsl:compile_parser' do
  watch %r{^src/rdsl/parser\.y$}
end

guard 'rake', :task => 'tdsl:compile_lexer' do
  watch %r{^src/tdsl/lexer\.rl$}
end