require_relative "lib/pub/sub/version"

Gem::Specification.new do |spec|
  spec.name        = "pub-sub"
  spec.version     = Pub::Sub::VERSION
  spec.authors     = [ "Orban Botond" ]
  spec.email       = [ "orbanbotond@gmail.com" ]
  spec.homepage    = "https://github.com/Logic-Optimum/pubsub"
  spec.summary     = "A simple PUB SUB Event Stream gem"
  spec.description = "A simple PUB SUB Event Stream gem"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Logic-Optimum/pubsub"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 8.0.0.rc2"
  spec.add_development_dependency 'shoulda-matchers', '~> 6.0'
  spec.add_development_dependency 'shoulda-context'
  spec.add_development_dependency 'debug'
end
