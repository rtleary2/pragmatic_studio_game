Gem::Specification.new do |s|
  s.name         = "w00ts-and-blams"
  s.version      = "0.0.1"
  s.author       = "Ryan Leary"
  s.email        = "ryanleary2@gmail.com"
  s.homepage     = 'https://rubygems.org/gems/example'
  s.summary      = "Watch the game play itself"
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))
  s.licenses     = ['MIT']

  s.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
  s.test_files    = Dir["spec/**/*"]
  s.executables   = [ 'studio_game' ]

  s.required_ruby_version = '>=1.9'
  s.add_development_dependency 'rspec'
end
