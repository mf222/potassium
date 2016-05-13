require "spec_helper"
require "rubocop"

RSpec.describe PotassiumTestHelpers do
  let(:app_name) { "#{tmp_path}/#{PotassiumTestHelpers::APP_NAME}" }

  before(:each) do
    remove_project_directory
    remove_project_directory
    drop_dummy_database
  end

  describe "#create_dummy_project" do
    it "should copy normal projects" do
      create_dummy_project
      expect(File.exist?(Pathname.new(app_name))).to eq(true)
    end

    it "should copy heroku enabled projects" do
      create_dummy_project("heroku" => true)
      expect(File.exist?(Pathname.new(app_name))).to eq(true)
    end

    it "should copy github enabled projects" do
      create_dummy_project("github" => true)
      expect(File.exist?(Pathname.new(app_name))).to eq(true)
    end

    it "should copy github private enabled projects" do
      create_dummy_project("github" => true, "github-private" => true)
      expect(File.exist?(Pathname.new(app_name))).to eq(true)
    end
  end
end
