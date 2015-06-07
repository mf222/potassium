module Potassium::DSL
  def self.extend_dsl(object, source_paths: __FILE__)
    require_relative './template_helpers'
    require_relative './variable_helpers'
    require_relative './environment_helpers'
    require_relative './gem_helpers'
    require_relative './callback_helpers'

    object.send :extend, TemplateHelpers
    object.send :extend, VariableHelpers
    object.send :extend, EnvironmentHelpers
    object.send :extend, GemHelpers
    object.send :extend, CallbackHelpers

    object.send :source_paths, source_paths
  end
end
