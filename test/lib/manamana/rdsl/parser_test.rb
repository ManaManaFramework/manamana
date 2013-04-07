require_relative '../../../test_helper'
require 'manamana/rdsl/parser'

module ManaMana

  module RDSL

    describe Parser do

      it "must parse an empty file" do
        output  = parse ""
        nodes   = RootNode.new
        output.must_equal nodes
      end

      it "must parse an empty group" do
        output = parse <<-EOF
                 Create a Project
                 ================
                 EOF
        nodes = RootNode.new({}, [
                  GroupNode.new({ value: 'Create a Project', offset: 17 })
                ])
        output.must_equal nodes
      end
      
      it "must parse multiple empty groups" do
        output = parse <<-EOF
                 Create a Project
                 ================
      
                 Create a User
                 =============
                 EOF
        nodes = RootNode.new({}, [
                  GroupNode.new({ value: 'Create a Project', offset: 17 }),
                  GroupNode.new({ value: 'Create a User', offset: 92 })
                ])
        output.must_equal nodes
      end
      
      it "must parse requirements" do
        output = parse <<-EOF
                 Create a Project
                 ================
      
                   * Given a user with role <Role>
               EOF
        nodes = RootNode.new({}, [
                  GroupNode.new({ value: 'Create a Project', offset: 17 }, [
                    RequirementNode.new({ value: 'Given a user with role <Role>', offset: 94 })
                  ])
                ])
        output.must_equal nodes
      end
      
      it "must parse a multi-line requirement" do
        output = parse <<-EOF
                 Create a Project
                 ================
      
                   * Given a
                     user with
                     role <Role>
               EOF
        nodes = RootNode.new({}, [
                  GroupNode.new({ value: 'Create a Project', offset: 17 }, [
                    RequirementNode.new({ value: "Given a user with role <Role>", offset: 94 })
                  ])
                ])
        output.must_equal nodes
      end
      
      it "must parse multiple non-empty groups" do
        output = parse <<-EOF
                 Create a Project
                 ================
      
                   * Projects without names are invalid
      
                 Create a User
                 =============
      
                   * Users with names are valid
                 EOF
        nodes = RootNode.new({}, [
                  GroupNode.new({ value: 'Create a Project', offset: 17 }, [
                    RequirementNode.new({ value: 'Projects without names are invalid', offset: 94 })
                  ]),
                  GroupNode.new({ value: 'Create a User', offset: 155 }, [
                    RequirementNode.new({ value: 'Users with names are valid', offset: 226 })
                  ])
                ])
        output.must_equal nodes
      end
      
      it "must parse tables" do
        output = parse <<-EOF
                 Create a Project
                 ================
      
                 * Given a
                   user with
                   role <Role>
      
                   Examples:
                    | Role | Remarks |
                    | PM   | ARRR    |
                    | User | RAAA    |
               EOF
        nodes = RootNode.new({}, [
                  GroupNode.new({ value: 'Create a Project', offset: 17 }, [
                    RequirementNode.new({ value: "Given a user with role <Role>", offset: 92 }, [
                      ExamplesNode.new({}, [
                        RowNode.new({ value: ['Role', 'Remarks'], offset: 218 }),
                        RowNode.new({ value: ['PM', 'ARRR'], offset: 257 }),
                        RowNode.new({ value: ['User', 'RAAA'], offset: 296 })
                      ])
                    ])
                  ])
                ])
        output.must_equal nodes
      end
      
      it "must parse multiple requirements" do
        output = parse <<-EOF
                 Project Management
                 ==================
      
                 * A <Role> in the system <Can or Cannot Create> projects
      
                     | Role | Can or Cannot Create |
                     |------|----------------------|
                     | PM   | Can Create           |
                     | User | Cannot Create        |
      
                 * An empty project is invalid
               EOF
        nodes = RootNode.new({}, [
                  GroupNode.new({ value: 'Project Management', offset: 17 }, [
                    RequirementNode.new({ value: "A <Role> in the system <Can or Cannot Create> projects", offset: 96 }, [
                      ExamplesNode.new({}, [
                        RowNode.new({ value: ['Role', 'Can or Cannot Create'], offset: 181 }),
                        RowNode.new({ value: ['PM', 'Can Create'], offset: 287 }),
                        RowNode.new({ value: ['User', 'Cannot Create'], offset: 340 })
                      ])
                    ]),
                    RequirementNode.new({ value: "An empty project is invalid", offset: 396 }, [])
                  ])
                ])
        output.must_equal nodes
      end
      
      it "must parse groups followed by arbitrary text" do
        output = parse <<-EOF
                   User Login
                   ==========
      
                   (Derived from: http://www.allaboutagile.com/user-story-example/)
      
                   As a registered user, I want to log in,
                   so I can access subscriber content.
      
                   Success:
      
                     * When I check 'Remember Me' and log in succesfully,
                       I won't have to login again next time
      
                     * When I uncheck 'Remember Me' and log in successfully,
                       I should be asked to login next time
                 EOF
        nodes = RootNode.new({}, [
                  GroupNode.new({ value: 'User Login', offset: 19 }, [
                    RequirementNode.new({ value: 'When I check \'Remember Me\' and log in succesfully, I won\'t have to login again next time', offset: 335 }),
                    RequirementNode.new({ value: 'When I uncheck \'Remember Me\' and log in successfully, I should be asked to login next time', offset: 477 })
                  ])
                ])
        output.must_equal nodes
      end

      def parse(file, show_tokens = false)
        Parser.new.parse(file, show_tokens)
      end

    end

  end
  
end