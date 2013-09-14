require_relative '../../../test_helper'
require 'manamana/tdsl/nodes'

module ManaMana

  module TDSL

    describe TestCaseNode do

      it "should translate if it is empty" do
        node = TestCaseNode.new 'A new user with attributes (.+), (.+) is valid'
        req  = "A new user with attributes Bob, 123qwe is valid"
        spec = <<-EOF
  describe %Q%A new user with attributes Bob, 123qwe is valid% do
    before do
      /^A new user with attributes (.+), (.+) is valid$/mi =~ %Q%A new user with attributes Bob, 123qwe is valid%
    end

    after do
    end

    it 'must pass' do
      raise 'Undefined test case'
    end
  end
EOF
        node.translate(req).must_equal spec
      end

      it "should translate preconditions" do
        node = TestCaseNode.new("A new user with attributes (.+), (.+) is valid", {
                 :variables     => VariablesNode.new('', [
                   AssignmentNode.new('My Username = my_username'),
                   AssignmentNode.new('My Password = my_password')
                 ]),
                 :preconditions => PreconditionsNode.new('', [
                    StepNode.new('Ensure user with attributes <My Username>, <My Password> exists')
                 ])
               })
        req  = "A new user with attributes Bob, 123qwe is valid"
        spec = <<-EOF
  describe %Q%A new user with attributes Bob, 123qwe is valid% do
    before do
      /^A new user with attributes (.+), (.+) is valid$/mi =~ %Q%A new user with attributes Bob, 123qwe is valid%
      Steps.call "Ensure user with attributes " + my_username + ", " + my_password + " exists"
    end

    after do
    end

    it 'must pass' do
      raise 'Undefined test case'
    end
  end
EOF
        node.translate(req).must_equal spec
      end

      it "should translate cleanup" do
        node = TestCaseNode.new("A new user with attributes (.+), (.+) is valid", {
                 :variables     => VariablesNode.new('', [
                   AssignmentNode.new('My Username = my_username'),
                   AssignmentNode.new('My Password = my_password')
                 ]),
                 :cleanup => CleanupNode.new('', [
                    StepNode.new('Ensure user with attributes <My Username>, <My Password> does not exist')
                 ])
               })
        req  = "A new user with attributes Bob, 123qwe is valid"
        spec = <<-EOF
  describe %Q%A new user with attributes Bob, 123qwe is valid% do
    before do
      /^A new user with attributes (.+), (.+) is valid$/mi =~ %Q%A new user with attributes Bob, 123qwe is valid%
    end

    after do
      Steps.call "Ensure user with attributes " + my_username + ", " + my_password + " does not exist"
    end

    it 'must pass' do
      raise 'Undefined test case'
    end
  end
EOF
        node.translate(req).must_equal spec
      end

      it "should translate the script" do
        node = TestCaseNode.new("A new user with attributes (.+), (.+) is valid", {
                 :variables     => VariablesNode.new('', [
                   AssignmentNode.new('My Username = my_username'),
                   AssignmentNode.new('My Password = my_password')
                 ]),
                 :script => ScriptNode.new('', [
                    StepNode.new('Fill in the username field with <My Username>'),
                    StepNode.new('Fill in the password field with <My Password>')
                 ])
               })
        req  = "A new user with attributes Bob, 123qwe is valid"
        spec = <<-EOF
  describe %Q%A new user with attributes Bob, 123qwe is valid% do
    before do
      /^A new user with attributes (.+), (.+) is valid$/mi =~ %Q%A new user with attributes Bob, 123qwe is valid%
    end

    after do
    end

    it 'must pass' do
      Steps.call "Fill in the username field with " + my_username + ""
      Steps.call "Fill in the password field with " + my_password + ""
    end
  end
EOF
        node.translate(req).must_equal spec
      end

    end # describe TestCaseNode

  end # module TDSL
  
end # module ManaMana