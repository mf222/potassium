class Recipes::Schedule < Rails::AppBuilder
  def ask
    use_schedule = answer(:schedule) { Ask.confirm("Do you need to schedule processes or tasks?") }
    set(:authorization, use_schedule)
  end

  def create
    gather_gem 'clockwork'
    copy_file '../assets/config/clock.rb', 'config/clock.rb'
    require 'pry'
    binding.pry

    if get(:heroku)
      procfile('scheduler', 'bundle exec clockwork config/clock.rb')
    end
  end

  def install
    create
  end

  def installed?
    gem_exists?(/clock/) && file_exist?('config/clock.rb')
  end
end
