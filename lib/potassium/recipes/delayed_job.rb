class Recipes::DelayedJob < Recipes::Base
  def ask
    enabled answer(:"delayed-job") { Ask.confirm("Do you want to use delayed jobs?") }
  end

  def create
    add_delayed_job if enabled
  end

  def install
    add_delayed_job
  end

  def installed?
    gem_exists?(/delayed_job_active_record/)
  end

  private

  def add_delayed_job
    # gather_gem "delayed_job_active_record"

    # delayed_job_config = "config.active_job.queue_adapter = :delayed_job"
    # application(delayed_job_config)

    after(:gem_install) do
      # generate "delayed_job:active_record"
      run "bundle binstubs delayed_job"
      add_readme_section :internal_dependencies, :delayed_job

      if selected?(:heroku)
        procfile('worker', 'bundle exec rake jobs:work')
      end
    end
  end
end
