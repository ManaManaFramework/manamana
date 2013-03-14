require_relative '../../../test_helper'
require 'manamana/tdsl/lexer'

module ManaMana

  module TDSL

    describe Lexer do

      section_labels = [ 'Variables', 'Preconditions', 'Cleanup', 'Script' ]

      section_labels.each do |section_label|
        it "must tokenize the #{ section_label } keyword" do
          output = tokenize <<-EOF
                   #{ section_label }:
                   EOF
          tokens = [ [section_label.upcase.to_sym, section_label] ]
          output.must_equal tokens
        end
      end

      it "must tokenize the test case name" do
        output = tokenize <<-EOF
                 Test Case:
                 A user who is a (.+) can create tickets in it
                 EOF
        tokens = [ [:TEST_CASE, 'A user who is a (.+) can create tickets in it'] ]
        output.must_equal tokens
      end

      it "must tokenize a Variables section" do
        output = tokenize <<-EOF
                 Variables:
                   * My Name       = $1
                   * A long variable name
                       = 'something'
                   * Role          = role_id
                 EOF
        tokens = [
                   [:VARIABLES, "Variables"],
                     [:LINE, "My Name = $1"],
                     [:LINE, "A long variable name = 'something'"],
                     [:LINE, "Role = role_id"]
                 ]
        output.must_equal tokens
      end

      it "must tokenize lines with multiple whitespace" do
        output = tokenize <<-EOF
                   * Ensure that the username <My Username> exists
                   * Ensure that the database
                     is cleaned up of previous
                     testing data
                   * Ensure   that   the   app is running
                 EOF
        tokens = [
                     [:LINE, "Ensure that the username <My Username> exists"],
                     [:LINE, "Ensure that the database is cleaned up of previous testing data"],
                     [:LINE, "Ensure that the app is running"]
                 ]
        output.must_equal tokens
      end

      def tokenize(data)
        Lexer.new.tokenize(data)
      end

    end # describe Lexer

  end # module TDSL
  
end # module ManaMana