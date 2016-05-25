class Recipes::MigrateFromNegroku < Rails::AppBuilder
  def install
    set(:heroku, true)
    pre_cleanup
    set :database, get_installed_database
    run_recipe :database
    run_recipe :heroku unless file_exist?('.buildpacks')
    run_recipe :style
    run_recipe :editorconfig
    run_recipe :secrets
    run_recipe :script
    run_recipe :puma
    run_recipe :pry
    run_recipe :staging
    run_recipe :production
    run_recipe :bower
    run_recipe :delayed_job if gem_exists?(/delayed_job/)
    run_recipe :paperclip if gem_exists?(/paperclip/)
    run_recipe :schedule if gem_exists?(/whenever/)
    run_recipe :ci
    run_recipe :env
    run_recipe :readme
    gather_gems(:development, :test) do
      gather_gem('dotenv-rails')
    end
    run_recipe :cleanup
    set_assets_for_heroku
    post_cleanup
  end

  private

  def run_recipe(recipe_name)
    recipe = load_recipe(recipe_name)
    recipe.enabled = true if recipe.respond_to?(:enabled)
    recipe.create
  end

  def discard_gem(gem)
    `sed -i'.bak' '/#{gem}/d' Gemfile && rm Gemfile.bak`
  end

  def pre_cleanup
    discard_gem 'negroku'
    `rm -f Capfile`
    `rm -f bin/cap`
    `rm -f bin/capify`
    `rm -f bin/negroku`
    `rm -f config/deploy.rb`
    `rm -rf config/deploy`
    `if [ -f .rbenv-vars.example ]; then mv -f .rbenv-vars.example .env.development; fi`
  end

  def post_cleanup
    discard_gem 'whenever'
    `rm -f config/schedule.rb`
  end

  def get_installed_database
    case
    when gem_exists?(/mysql2/)
      :mysql
    when gem_exists?(/pg/)
      :postgresql
    else
      :none
    end
  end

  def set_assets_for_heroku
    if(gem_exists?(/rails.*4\.1/))
      gsub_file 'config/environments/production.rb', /config\.serve_static_files = false/ do
        'config.serve_static_files = ENV[\'RAILS_SERVE_STATIC_FILES\'].present?'
      end
    end
  end
end
