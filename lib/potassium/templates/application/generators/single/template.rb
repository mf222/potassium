set :app_name, application_name
set :titleized_app_name, get(:app_name).titleize
set :underscorized_app_name, get(:app_name).underscore

run_action(:recipe_loading) do
  set(:api_support, true)
  eval_file "recipes/#{get(:recipe)}.rb"
end

run_action(:gem_install) do
  build_gemfile
  run "bundle install"
end
