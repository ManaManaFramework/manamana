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
        tokens = [ [:GROUP, { value: 'Create a Project', offset: 17 }] ]
        output.must_equal tokens
      end

      it "must tokenize strings" do
        output = tokenize <<-EOF
                 Arbitrary text
                 of the unusual kind
                 EOF
        tokens = [ [:TEXT, { value: 'Arbitrary text of the unusual kind', offset: 17 }] ]
        output.must_equal tokens
      end
      
      it "must tokenize a requirement" do
        output = tokenize <<-EOF
                 * A project without a name is invalid
                 EOF
        tokens = [ [:REQUIREMENT, { value: 'A project without a name is invalid', offset: 17 }] ]
        output.must_equal tokens
      end
      
      it "must tokenize a requirement followed by arbitrary text" do
        output = tokenize <<-EOF
                 * A project without a name is invalid
      
                   Example:
                     Arbitrary text
                 EOF
        tokens = [ 
                   [:REQUIREMENT, { value: 'A project without a name is invalid', offset: 17 }], 
                   [:TEXT, { value: 'Example: Arbitrary text', offset: 81 }] 
                 ]
        output.must_equal tokens
      end
      
      it "must tokenize a multi-line requirement" do
        output = tokenize <<-EOF
                 * A project without a
                   name is invalid
                 EOF
        tokens = [ [:REQUIREMENT, { value: 'A project without a name is invalid', offset: 17 }] ]
        output.must_equal tokens
      end
      
      it "must tokenize a multi-line requirement followed by arbitrary text" do
        output = tokenize <<-EOF
                 * A project without
                   a name is invalid
      
                   Example:
                     Arbitrary text
                 EOF
        tokens = [ 
                   [:REQUIREMENT, { value: 'A project without a name is invalid', offset: 17 }], 
                   [:TEXT, { value: 'Example: Arbitrary text', offset: 100 }] 
                 ]
        output.must_equal tokens
      end
      
      it "must tokenize tables" do
        output = tokenize <<-EOF
                  | Name      | Description       |
                  | Project A | First Project     |
                  | Project B | Second Project    |
                EOF
        tokens = [
                   [:ROW, { offset:  18 }], [:CELL, 'Name'],      [:CELL, 'Description'],
                   [:ROW, { offset:  70 }], [:CELL, 'Project A'], [:CELL, 'First Project'],
                   [:ROW, { offset: 122 }], [:CELL, 'Project B'], [:CELL, 'Second Project']
                 ]
        output.must_equal tokens
      end
      
      it "must ignore table borders" do
        output = tokenize <<-EOF
                  | Name      | Description       |
                  |-----------|-------------------|
                  | Project A | First Project     |
                  | Project B | Second Project    |
                EOF
        tokens = [
                   [:ROW, { offset:  18 }], [:CELL, 'Name'],      [:CELL, 'Description'],
                   [:ROW, { offset: 122 }], [:CELL, 'Project A'], [:CELL, 'First Project'],
                   [:ROW, { offset: 174 }], [:CELL, 'Project B'], [:CELL, 'Second Project']
                 ]
        output.must_equal tokens
      end
      
      it "must tokenize requirements with placeholders" do
        output = tokenize <<-EOF
                 * Given <Role>
                   <Something>
                 EOF
        tokens = [ [:REQUIREMENT, { value: 'Given <Role> <Something>', offset: 17 }] ]
        output.must_equal tokens
      end
      
      it "must tokenize a full requirements file" do
        output = tokenize <<-EOF
               Create a Project
               ================
      
               * Given a user has a role of <Role> in the system
                 Then he <Can or Cannot Create> projects
      
                 Examples:
                   | Role  | Can or Cannot Create |
                   | Admin | Can Create           |
                   | User  | Cannot Create        |
      
                 Notes:
                   The quick brown fox jumps over the lazy
                   dog. The quick brown fox jumps.
               EOF
        tokens = [
                   [:GROUP, { value: 'Create a Project', offset: 15 }],
                   [:REQUIREMENT, { value: 'Given a user has a role of <Role> in the system Then he <Can or Cannot Create> projects', offset: 86 }],
                   [:TEXT, { value: 'Examples:', offset: 217 }],
                   [:ROW, { offset: 246 }], [:CELL, 'Role'], [:CELL, 'Can or Cannot Create'],
                   [:ROW, { offset: 298 }], [:CELL, 'Admin'], [:CELL, 'Can Create'],
                   [:ROW, { offset: 350 }], [:CELL, 'User'], [:CELL, 'Cannot Create'],
                   [:TEXT, { value: 'Notes: The quick brown fox jumps over the lazy dog. The quick brown fox jumps.', offset: 407 }]
                 ]
        output.must_equal tokens
      end
      
      it "must tokenize a requirements file with arbitrary text right under the group name" do
        output = tokenize <<-EOF
                   User Login
                   ==========
                   (Derived from: http://www.allaboutagile.com/user-story-example/)
      
                   As a registered user, I want to log in,
                   so I can access subscriber content.
      
                   Success:
      
                     * When I check 'Remember Me' and log in succesfully,
                       I won't have to login again next time
                 EOF
        tokens = [
                   [:GROUP, { value: 'User Login', offset: 19 }],
                   [:TEXT,  { value: '(Derived from: http://www.allaboutagile.com/user-story-example/)', offset: 79 }],
                   [:TEXT,  { value: 'As a registered user, I want to log in, so I can access subscriber content.', offset: 170 }],
                   [:TEXT,  { value: 'Success:', offset: 291 }],
                   [:REQUIREMENT, { value: 'When I check \'Remember Me\' and log in succesfully, I won\'t have to login again next time', offset: 328 }]
                 ]
        output.must_equal tokens
      end

      def tokenize(data)
        Lexer.new.tokenize(data)
      end
      
    end # describe Lexer

  end # module RDSL
  
end # module ManaMana