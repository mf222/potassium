require "potassium/version"
require "potassium/messages"
require "gli"
require "gems"

module Potassium::CLI
  extend GLI::App

  version Potassium::VERSION
  hide_commands_without_desc true

  commands_from "potassium/cli/commands"

  pre do |global_options, command, options, args|
    if command.name == :create && args.empty?
      help_now!(Potassium::Messages.potassium_needs_a_project_name)
    end

    if Gems.versions('potassium').first['number'] != Potassium::VERSION
      exit_now!(Potassium::Messages.please_update_potassium)
    end

    true
  end

  exit Potassium::CLI.run(ARGV)
end
