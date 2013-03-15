require 'singleton'

module ManaMana

  class Steps
    include Singleton

    def self.add(pattern, &block)
      instance.add pattern, &block
    end

    def self.call(pattern)
      instance.call pattern
    end

    attr_reader :steps

    def initialize
      @steps = []
    end

    def add(pattern, &block)
      steps << { pattern: pattern, block: block }
    end

    # The step_name variable below is a string that may or
    # may not match the regex pattern of one of the hashes
    # in the steps array.
    def call(step_name)
      vars = nil
      step = steps.find { |s| vars = s[:pattern].match(step_name) }

      raise "Undefined step '#{ step_name }'" unless step

      if vars.length > 1
        step[:block].call(*vars[1..-1])
      else
        step[:block].call
      end
    end

  end


  def step(pattern, &block)
    Steps.add pattern, &block
  end

end