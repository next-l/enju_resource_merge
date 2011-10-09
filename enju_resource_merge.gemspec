$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "enju_resource_merge/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "enju_resource_merge"
  s.version     = EnjuResourceMerge::VERSION
  s.authors     = ["Kosuke Tanabe"]
  s.email       = ["tanabe@mwr.mediacom.keio.ac.jp"]
  s.homepage    = "https://github.com/nabeta/enju_resource_merge"
  s.summary     = "enju_resource_merge plugin"
  s.description = "Merge resource records for Next-L Enju"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.0.10"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
