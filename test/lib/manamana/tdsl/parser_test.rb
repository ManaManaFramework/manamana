require_relative '../../../test_helper'
require 'manamana/tdsl/parser'

module ManaMana

  module TDSL

    describe Parser do

      it "must parse an empty file" do
        output  = parse ""
        nodes   = RootNode.new
        output.must_equal nodes
      end

      it "must parse an empty test case" do
        output = parse <<-EOF
                 Test Case:
                   A user who is a (.+) can create tickets in it
                 EOF
        nodes = RootNode.new('', [
                  TestCaseNode.new('A user who is a (.+) can create tickets in it')
                ])
        output.must_equal nodes
      end

      it "must parse multiple empty test cases" do
        output = parse <<-EOF
                 Test Case:
                   A user who is a (.+) can create tickets in it

                 Test Case:
                   A user who is a (.+) cannot create tickets in it
                 EOF
        nodes = RootNode.new('', [
                  TestCaseNode.new('A user who is a (.+) can create tickets in it'),
                  TestCaseNode.new('A user who is a (.+) cannot create tickets in it')
                ])
        output.must_equal nodes
      end

      it "must parse the variables section" do
        file   = <<-EOF
                 Test Case:
                   A user who is a Manager can create tickets in it

                   Variables:
                     * My Username = $1
                     * My Password = my_password
                 EOF
        output = parse file
        nodes  = RootNode.new('', [
                   TestCaseNode.new('A user who is a Manager can create tickets in it', {
                     :variables => VariablesNode.new('', [
                       AssignmentNode.new('My Username = $1'),
                       AssignmentNode.new('My Password = my_password')
                     ])
                   })
                 ])
        output.must_equal nodes
      end

      it "must parse the preconditions section" do
        file   = <<-EOF
                 Test Case:
                   A user who is a Manager can create tickets in it

                   Preconditions:
                     * Ensure a user with username Bob exists
                     * This is another step that
                       wraps to the next line
                 EOF
        output = parse file
        nodes  = RootNode.new('', [
                   TestCaseNode.new('A user who is a Manager can create tickets in it', {
                     :preconditions => PreconditionsNode.new('', [
                       StepNode.new('Ensure a user with username Bob exists'),
                       StepNode.new('This is another step that wraps to the next line')
                     ])
                   })
                 ])
        output.must_equal nodes
      end

      it "must parse the cleanup section" do
        file   = <<-EOF
                 Test Case:
                   A user who is a Manager can create tickets in it

                   Cleanup:
                     * Delete <My Username> at exit
                 EOF
        output = parse file
        nodes  = RootNode.new('', [
                   TestCaseNode.new('A user who is a Manager can create tickets in it', {
                     :cleanup => CleanupNode.new('', [
                       StepNode.new('Delete <My Username> at exit')
                     ])
                   })
                 ])
        output.must_equal nodes
      end

      it "must parse the script section" do
        file   = <<-EOF
                 Test Case:
                   A user who is a Manager can create tickets in it

                   Script:
                     * Click the Log Out button
                 EOF
        output = parse file
        nodes  = RootNode.new('', [
                   TestCaseNode.new('A user who is a Manager can create tickets in it', {
                     :script => ScriptNode.new('', [
                       StepNode.new('Click the Log Out button')
                     ])
                   })
                 ])
        output.must_equal nodes
      end

      it "must parse multiple non-empty test cases" do
        file   = <<-EOF
                 Test Case:
                   A user who is a Manager can create tickets in it

                   Script:
                     * Click the Log Out button

                 Test Case:
                   A user who is a (.+) cannot create tickets

                   Variables:
                     * My Username = 'Bob'

                   Script:
                     * Click the Log Out button
                     * Fill in the Username field with <My Username>
                 EOF
        output = parse file
        nodes  = RootNode.new('', [
                   TestCaseNode.new('A user who is a Manager can create tickets in it', {
                     :script => ScriptNode.new('', [
                       StepNode.new('Click the Log Out button')
                     ])
                   }),

                   TestCaseNode.new('A user who is a (.+) cannot create tickets', {
                     :variables => VariablesNode.new('', [
                       AssignmentNode.new('My Username = \'Bob\'')
                      ]),
                     :script => ScriptNode.new('', [
                       StepNode.new('Click the Log Out button'),
                       StepNode.new('Fill in the Username field with <My Username>')
                     ])
                   })
                 ])

        output.must_equal nodes
      end

      def parse(file, show_tokens = false)
        Parser.new.parse(file, show_tokens)
      end

    end

  end
  
end