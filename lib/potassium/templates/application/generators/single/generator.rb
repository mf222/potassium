require "rails/generators"

module Potassium
  module Application
    class SingleGenerator < Rails::Generators::NamedBase
      class << self
        attr_accessor :potassium
      end

      def prepare
        require "potassium/dsl/dsl"
        DSL.extend_dsl(self, source_paths: [File.expand_path('../../..', __FILE__)])
        set(:recipe, self.class.potassium[:recipe])
      end

      def check_recipe_ability
        # if get(:recipe)
      end

      def run_recipe
        generator_template_location = File.expand_path(
          './template.rb', File.dirname(__FILE__)
        )
        instance_eval File.read(generator_template_location), generator_template_location
      end
    end
  end
end
