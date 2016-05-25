module Recipes
  class Base < Rails::AppBuilder

    attr_reader :enabled

    def initialize(args)
      super(args)
      @enabled = false
    end

    def enabled=(enabled)
      set(:heroku, enabled)
      @enabled = enabled
    end
  end
end
