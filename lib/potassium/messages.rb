require "term/ansicolor"

module Potassium
  module Messages
    extend Term::ANSIColor
    extend self

    def please_update_potassium
      str = ""
      str << "\n\nYou need to update potassium first. Please run:\n\n"
      str << green("    gem update potassium\n\n")
      str << "And try again.\n"
      str
    end

    def potassium_needs_a_project_name
      "`potassium create` needs a project name."
    end
  end
end
