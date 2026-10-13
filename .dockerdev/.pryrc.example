# frozen_string_literal: true

require "rubygems"

Pry.config.history_file = "/usr/local/hist/.irb_history"
Pry.config.editor = "vim"
Pry.config.color = true
# run `gem install pry-theme` if you don't have it installed
Pry.config.theme = "tomorrow"

Pry.config.prompt = (Pry::Prompt.new(
  "pry prompt with env",
  "custom prompt displaying rails env",
  [
    proc { |obj, nest_level, pry|
      "[#{pry.input_ring.size}][#{PryRails::Prompt.formatted_env}] (#{obj}):#{nest_level} > "
    },
    proc { |obj, nest_level, pry|
      "[#{pry.input_ring.size}][#{PryRails::Prompt.formatted_env}] (#{obj}):#{nest_level} * "
    }
  ]
))

Pry.commands.alias_command "c", "continue"
Pry.commands.alias_command "s", "step"
Pry.commands.alias_command "n", "next"
Pry.commands.alias_command "f", "finish"
Pry.commands.alias_command "e", "exit"
Pry.commands.alias_command "ep", "exit-program"
Pry.commands.alias_command "wai", "whereami"

Pry.config.print = proc do |output, value|
  Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output)
rescue StandardError
  output.puts "=> #{value}"
end

Pry.config.ls.separator = "\n" # new lines between methods
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black

begin
  require "amazing_print"
  # The following line enables awesome_print for all pry output,
  # and it also enables paging
  Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }

  # If you want awesome_print without automatic pagination, use the line below
  module AmazingPrint
    Formatter.prepend(Module.new do
      def awesome_self(object, type)
        if type == :string && @options[:string_limit] && object.inspect.to_s.length > @options[:string_limit]
          colorize("#{object.inspect.to_s[0..@options[:string_limit]]}...", type)
        else
          super(object, type)
        end
      end
    end)
  end

  AmazingPrint.defaults = {
    string_limit: 120,
    indent: 2,
  }
  AmazingPrint.pry!
rescue LoadError => _e
  puts "gem install amazing_print  # <-- highly recommended"
end

if defined?(Rails) && Rails.env
  Rails.application.config.colorize_logging = true
  ActiveRecord::Base.logger = Logger.new($stdout)

  Rails.application.config.console = Pry unless Rails.application.config.console == Pry
end
