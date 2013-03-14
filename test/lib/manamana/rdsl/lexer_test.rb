require_relative '../../../test_helper'
require 'manamana/rdsl/lexer'

module ManaMana

  module RDSL

    describe Lexer do

      it "must be defined" do
        Lexer.wont_be_nil
      end

      it "must tokenize the group name" do
        output = tokenize <<-EOF
                 Create a Project
                 ================
                 EOF
        tokens = [ [:GROUP, 'Create a Project'] ]
        output.must_equal tokens
      end


      def tokenize(data)
        Lexer.new.tokenize(data)
      end
      
    end # describe Lexer

  end # module RDSL
  
end # module ManaMana