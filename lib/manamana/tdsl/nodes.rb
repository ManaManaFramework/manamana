module ManaMana
  
  module TDSL

    class Node
      attr_reader :children, :name

      def initialize(name='', children=[])
        @children = children
        @name     = name
      end

      def ==(other_node)
        name == other_node.name && children == other_node.children
      end
    end

    class PreconditionsNode < Node; end
    class CleanupNode < Node; end
    class ScriptNode < Node; end
    class StepNode < Node; end

    class RootNode < Node
      def find(string)
        children.find { |tc| tc.test string } || TestCaseNode.new
      end
    end

    class VariablesNode < Node
      def assignments
        children
      end
    end

    class AssignmentNode < Node
      attr_reader :key, :value

      def initialize(name = '', children = [])
        @key, @value = name.split('=').map{ |n| n.strip }
      end

      def gsub!(string)
        string.gsub! /\<#{ key }\>/, "\" + " + value + " + \""
      end
    end

    class TestCaseNode < Node
      attr_reader :regex

      def initialize(name='', children={})
        unless children.class == Hash
          raise "Second parameter must be a Hash"
        end

        children[:variables]     = children.delete(:variables) || VariablesNode.new
        children[:preconditions] = children.delete(:preconditions) || PreconditionsNode.new
        children[:cleanup]       = children.delete(:cleanup) || CleanupNode.new
        children[:script]        = children.delete(:script) || ScriptNode.new

        @regex = Regexp.new("^#{name}$", Regexp::IGNORECASE)

        super name, children
      end

      def ==(other_node)
        self.class       == other_node.class &&
        name             == other_node.name &&
        variables        == other_node.variables &&
        preconditions    == other_node.preconditions &&
        cleanup          == other_node.cleanup &&
        script           == other_node.script
      end

      def test(string)
        !(regex =~ string).nil?
      end

      def translate(requirement)
        spec = ""
        spec << "  describe %Q%#{ requirement }% do\n"
        spec << "    before do\n"

        # Make the $1, $2, etc variables available to this spec
        spec << "      #{ regex.inspect } =~ %Q%#{ requirement }%\n"

        preconditions.each do |step|
          str = step.name.dup
          variables.each do |assignment|
            assignment.gsub! str
          end

          spec << "      Steps.call \"" + str + "\"\n"
        end

        spec << "    end\n\n"

        spec << "    after do\n"

        cleanup.each do |step|
          str = step.name.dup
          variables.each do |assignment|
            assignment.gsub! str
          end

          spec << "      Steps.call \"" + str + "\"\n"
        end

        spec << "    end\n\n"

        spec << "    it 'must pass' do\n"

        script.each do |step|
          str = step.name.dup
          variables.each do |assignment|
            assignment.gsub! str
          end

          spec << "      Steps.call \"" + str + "\"\n"
        end

        if script.length == 0
          spec << "      raise 'Undefined test case'\n"
        end

        spec << "    end\n"
        spec << "  end\n"
        spec
      end

      def variables
        children[:variables].children
      end

      def preconditions
        children[:preconditions].children
      end

      def cleanup
        children[:cleanup].children
      end

      def script
        children[:script].children
      end
    end

  end

end