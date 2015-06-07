module Potassium::CLI
  desc "Create a new Potassium Rails project."
  arg 'app_path'
  command :create do |c|
    c.default_desc "Create a new project."
    c.action do |global_options, options, args|
      require "potassium/template_finder"

      template_finder = Potassium::TemplateFinder.new
      template = template_finder.default_template[:app_generator]
      template.source_paths << Rails::Generators::AppGenerator.source_root
      template.start
    end
  end
end
