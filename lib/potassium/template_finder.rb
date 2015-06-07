module Potassium
  class TemplateFinder
    TEMPLATES = {
      default: ->do
        require "potassium/templates/application/generators/app/generator"
        require "potassium/templates/application/generators/single/generator"
        {
          app_generator: Potassium::Application::AppGenerator,
          single_generator: Potassium::Application::SingleGenerator
        }
      end
    }

    def default_template
      find(:default).call()
    end

    def find(name)
      TEMPLATES.fetch(name)
    end
  end
end
