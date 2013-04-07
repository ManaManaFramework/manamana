require_relative '../../../test_helper'
require 'manamana/rdsl/nodes'

module ManaMana
  
  module RDSL

    describe RequirementNode do

      it "must expand examples" do
        nodes = RequirementNode.new({ value: "A <Role> in the system <Can or Cannot Create> projects" }, [
                  ExamplesNode.new({}, [
                    RowNode.new({ value: ['Role', 'Can or Cannot Create'] }),
                    RowNode.new({ value: ['PM', 'Can Create'] }),
                    RowNode.new({ value: ['User', 'Cannot Create'] })
                  ])
                ])
        array = [
                  'A PM in the system Can Create projects',
                  'A User in the system Cannot Create projects'
                ]
        nodes.expand.must_equal array
      end

      it "must return its name when expand is called and no examples exist" do
        nodes = RequirementNode.new({ value: "A PM in the system can create projects" })
        array = ['A PM in the system can create projects']
        nodes.expand.must_equal array
      end


    end

  end

end