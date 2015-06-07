require "rails/generators"
require "rails/generators/rails/app/app_generator"
require "inquirer"

module Potassium
  module Application
    class AppGenerator < Rails::Generators::AppGenerator
      def finish_template
        require "potassium/dsl/dsl"
        DSL.extend_dsl(self, source_paths: [File.expand_path('../../..', __FILE__)])
        template_location = File.expand_path('./template.rb', File.dirname(__FILE__))
        instance_eval File.read(template_location), template_location
        super
      end
    end
  end
end
