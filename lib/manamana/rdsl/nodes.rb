module ManaMana
  
  module RDSL

    class Node
      attr_reader :children, :name

      def initialize(name='', children=[])
        @children = children
        @name     = name
      end

      def ==(other_node)
        name == other_node.name && @children == other_node.children
      end
    end

    class RootNode < Node
      def all_requirements
        groups.map{ |g| g.requirements }.flatten.map{ |r| r.expand }.flatten
      end

      def groups
        children
      end
    end

    class GroupNode < Node
      def all_requirements
        requirements.map{ |r| r.expand }.flatten
      end

      def requirements
        children
      end
    end

    class RequirementNode < Node
      def examples
        # RowNode.new('', ['Role', 'Can or Cannot Create']),
        # RowNode.new('', ['PM',   'Can Create'          ]),
        # RowNode.new('', ['User', 'Cannot Create'       ])

        # [
        #   { '<Role>' => 'PM',   '<Can or Cannot Create>' => 'Can Create'    },
        #   { '<Role>' => 'User', '<Can or Cannot Create>' => 'Cannot Create' }
        # ]
        return [] if children.length == 0

        nodes   = children[0].rows
        headers = nodes[0].cells
        rows    = []

        nodes[1..-1].each do |node|
          row = {}
          node.cells.each_with_index do |value, index|
            row["<#{headers[index]}>"] = value
          end
          rows << row
        end

        rows
      end

      def expand
        return [name] if examples.length == 0

        requirements = []

        examples.each do |row|
          tmp = name.dup
          row.each_key do |key|
            tmp.gsub! key, row[key]
          end
          requirements << tmp
        end

        requirements
      end
    end

    class ExamplesNode < Node
      def rows
        children
      end
    end


    class RowNode < Node
      def cells
        children
      end
    end

  end

end