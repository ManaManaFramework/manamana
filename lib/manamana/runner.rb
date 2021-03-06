module ManaMana

  class Runner
    def recursive_require(in_dir)
      Dir.entries(in_dir).each do |entry|
        next if ['.', '..'].include? entry

        path = File.join(in_dir, entry)

        if File.directory?(path)
          recursive_require(path)
        elsif File.extname(path) == '.rb'
          require path
        end
      end
    end

    def start
      require 'minitest/autorun'

      recursive_require File.join(Dir.pwd, LIB_PATH)
      require File.join(Dir.pwd, '__spec__.rb')
    end
  end

end