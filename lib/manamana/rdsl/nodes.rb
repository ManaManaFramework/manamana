module ManaMana
  
  module RDSL

    class Node
      attr_reader :children, :name

      def initialize(options={}, children=[])
        @children = children
        @name     = options[:value] || ''
      end

      def ==(other_node)
        name == other_node.name && @children == other_node.children
      end
    end
    
    class NodeWithOffset < Node
      attr_reader :offset
      
      def initialize(options={}, children=[])
        @offset = options[:offset] || nil
        super options, children
      end
      
      def ==(other_node)
        super(other_node) && @offset == other_node.offset
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

    class GroupNode < NodeWithOffset
      def all_requirements
        requirements.map{ |r| r.expand }.flatten
      end

      def requirements
        children
      end
    end

    class RequirementNode < NodeWithOffset
      def examples
        # RowNodes initialized this way:
        # RowNode.new({ value: ['Role', 'Can or Cannot Create'], offset: XX }),
        # RowNode.new({ value: ['PM',   'Can Create'          ], offset: XX }),
        # RowNode.new({ value: ['User', 'Cannot Create'       ], offset: XX })

        # ...will be returned by this method this way:
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


    class RowNode < NodeWithOffset
      def cells
        name
      end
    end

  end

end