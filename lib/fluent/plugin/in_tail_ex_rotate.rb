require 'fluent/plugin/in_tail'

module Fluent
  class TailExRotateInput < Fluent::NewTailInput
    Fluent::Plugin.register_input('tail_ex_rotate', self)
    config_param :expand_rotate_time, :time, :default => 0

    def expand_paths
      date = Time.now - @expand_rotate_time
      paths = []
      @paths.each { |path|
        path = date.strftime(path)
        if path.include?('*')
          paths += Dir.glob(path)
        else
          # When file is not created yet, Dir.glob returns an empty array. So just add when path is static.
          paths << path
        end
      }
      paths
    end
  end
end
