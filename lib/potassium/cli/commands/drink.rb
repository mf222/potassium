module Potassium::CLI
  desc "Applies a recipe to the current Rails project"
  arg 'recipe_name'
  command :drink do |c|
    pre do |global_options, command, options, args|
      next true if command.name != :drink
      
      begin
        require File.expand_path('config/application', Dir.pwd)

        if args.first.nil?
          help_now!("recipe_name attribute is required.")
        end

        true
      rescue LoadError => e
        puts "A Rails app couldn't be found from here. Please go to the root of your rails application and try again"
        false
      end
    end

    c.default_desc "Applies a recipe."
    c.action do |global_options, options, args|
      require "rails/generators"
      require_relative "../../template_finder"
      recipe = args.first

      template_finder = Potassium::TemplateFinder.new
      generator = template_finder.default_template[:single_generator]
      generator.potassium = { recipe: recipe }
      generator.start
    end
  end
end
