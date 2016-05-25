class Recipes::Bower < Rails::AppBuilder
  def create
    copy_file '../assets/.bowerrc', '.bowerrc'
    template '../assets/bower.json', 'bower.json' unless file_exist? 'bower.json'
    application "config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')"

    append_to_file '.gitignore', "vendor/assets/bower_components\n"

    if get(:heroku)
      bower_buildpack_url = 'https://github.com/platanus/heroku-buildpack-bower.git'
      insert_point = 'https://github.com/platanus/heroku-buildpack-ruby-version.git'
      inject_into_file '.buildpacks', "#{bower_buildpack_url}\n", before: insert_point
    end
  end

  def install
    heroku_recipe = load_recipe(:heroku)
    set(:heroku, heroku_recipe.installed?)
    create
  end
end
