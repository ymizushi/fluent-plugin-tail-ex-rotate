require 'cool.io'

require 'fluent/plugin/input'
require 'fluent/config/error'
require 'fluent/event'
require 'fluent/plugin/buffer'
require 'fluent/plugin/parser_multiline'

if Fluent.windows?
  require_relative 'file_wrapper'
else
  Fluent::FileWrapper = File
end

module Fluent::Plugin
  class TailExRotateInput < Fluent::Plugin::TailInput
    Fluent::Plugin.register_input('tail_ex_rotate', self)
    config_param :expand_rotate_time, :time, :default => 0

    def expand_paths
      date = Time.now - @expand_rotate_time
      paths = []

      @paths.each { |path|
        path = date.strftime(path)
        if path.include?('*')
          paths += Dir.glob(path).select { |p|
            is_file = !File.directory?(p)
            if File.readable?(p) && is_file
              if @limit_recently_modified && File.mtime(p) < (date - @limit_recently_modified)
                false
              else
                true
              end
            else
              if is_file
                unless @ignore_list.include?(path)
                  log.warn "#{p} unreadable. It is excluded and would be examined next time."
                  @ignore_list << path if @ignore_repeated_permission_error
                end
              end
              false
            end
          }
        else
          # When file is not created yet, Dir.glob returns an empty array. So just add when path is static.
          paths << path
        end
      }
      excluded = @exclude_path.map { |path| path = date.strftime(path); path.include?('*') ? Dir.glob(path) : path }.flatten.uniq
      paths - excluded
    end
  end
end
