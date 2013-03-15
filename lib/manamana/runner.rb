module ManaMana

  class Runner
    def recursive_require(in_dir)
      Dir.entries(in_dir).each do |entry|
        next if ['.', '..'].include? entry

        path = File.join(in_dir, entry)

        if File.directory?(path)
          recursive_require(path)
        else
          require path
        end
      end
    end

    def start
      require 'minitest/autorun'
      require 'minitest/colorize'

      recursive_require File.join(Dir.pwd, 'directives', 'utilities')
      require File.join(Dir.pwd, '__spec__.rb')
    end
  end

end