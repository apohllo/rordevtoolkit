require 'lib/builder.rb'
require 'find'

PACKAGES["app"].each do |package, options|
  namespace package.to_sym do
    if options.keys.member?(distribution.to_s)
      desc "Install #{options['desc']}"
      task :install  do
        pinstall package.to_sym
      end
    end
  end
end

PACKAGES["gem"].each do |package, gems|
  namespace package.to_sym do
    # namespace :gem do
    desc "Install gem and related gems: #{package}"
    task :gem_install do
      ginstall package.to_sym
    end
    # end
  end
end


Dir['./lib/tasks/**/*.rb'].each  do |path|
  require "#{path}"
end

desc "List :all meta-tasks"
task :list do
  info "List of meta-tasks"
  run "rake -T | grep -e \"\\:all.*\\#\""

  info "List of metapackages all-in-one"
  run "rake -T | grep -e \"\\devel.*\\#\""
end
