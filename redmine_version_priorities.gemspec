# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{redmine_version_priorities}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eric Davis"]
  s.date = %q{2010-05-06}
  s.description = %q{A Redmine plugin to prioritize versions to help users make a decision on which issues need to be worked on next.}
  s.email = %q{edavis@littlestreamsoftware.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "COPYRIGHT.txt",
     "CREDITS.txt",
     "GPL.txt",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "app/controllers/version_priorities_controller.rb",
     "app/views/version_priorities/_prioritized_versions.html.erb",
     "app/views/version_priorities/_version.html.erb",
     "app/views/version_priorities/show.html.erb",
     "assets/javascripts/jquery-1.4.2.min.js",
     "assets/javascripts/jquery-ui-1.8.1.custom.min.js",
     "assets/javascripts/jquery.ajax_queue.js",
     "assets/javascripts/redmine_version_priorities.js",
     "assets/stylesheets/redmine_version_priorities.css",
     "config/locales/en.yml",
     "config/routes.rb",
     "init.rb",
     "lang/en.yml",
     "lib/redmine_version_priorities/patches/issue_patch.rb",
     "lib/redmine_version_priorities/patches/query_patch.rb",
     "lib/redmine_version_priorities/patches/version_patch.rb",
     "test/functional/version_priorities_controller.rb",
     "test/integration/edit_version_priorities_test.rb",
     "test/integration/view_version_priorities_test.rb",
     "test/test_helper.rb",
     "test/unit/lib/redmine_version_priorities/patches/issue_patch_test.rb",
     "test/unit/lib/redmine_version_priorities/patches/query_patch_test.rb",
     "test/unit/lib/redmine_version_priorities/patches/version_patch_test.rb"
  ]
  s.homepage = %q{https://projects.littlestreamsoftware.com/projects/version-priorities}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{TODO}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{A Redmine plugin that allows versions to be prioritized.}
  s.test_files = [
    "test/test_helper.rb",
     "test/integration/view_version_priorities_test.rb",
     "test/integration/edit_version_priorities_test.rb",
     "test/unit/lib/redmine_version_priorities/patches/version_patch_test.rb",
     "test/unit/lib/redmine_version_priorities/patches/issue_patch_test.rb",
     "test/unit/lib/redmine_version_priorities/patches/query_patch_test.rb",
     "test/functional/version_priorities_controller.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

