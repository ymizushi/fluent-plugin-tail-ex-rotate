require 'fluent/plugin/in_tail'

module Fluent
  class TailExRotateInput < Fluent::NewTailInput
    Fluent::Plugin.register_input('tail_ex_rotate', self)
    config_param :expand_rotate_time, :time, :default => 0

    def expand_paths
      date = Time.now - @expand_rotate_time
      paths = []

      excluded = @exclude_path.map { |path| path = date.strftime(path); path.include?('*') ? Dir.glob(path) : path }.flatten.uniq
      @paths.each { |path|
        path = date.strftime(path)
        if path.include?('*')
          paths += Dir.glob(path).select { |p|
            if File.readable?(p)
              true
            else
              log.warn "#{p} unreadable. It is excluded and would be examined next time."
              false
            end
          }
        else
          # When file is not created yet, Dir.glob returns an empty array. So just add when path is static.
          paths << path
        end
      }
      paths - excluded
    end
  end
end
