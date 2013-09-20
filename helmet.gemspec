require './lib/helmet/version'

Gem::Specification.new do |s|
  s.name          = 'helmet'
  s.version       = Helmet::VERSION
  s.platform      = Gem::Platform::RUBY
  s.date          = Time.now
  s.summary       = 'Simple web framework for Goliath web server.'
  s.description   = s.summary
  s.authors       = ['Thiago Lewin']
  s.email         = 'thiago_lewin@yahoo.com.br'
  s.require_path  = 'lib'
  s.files         = Dir['{lib/**/*,examples/**/*,test/**/*}', 'README.md', 'Rakefile', 'HISTORY.md', 'Gemfile', 'helmet.gemspec', 'LICENSE']
  s.test_files    = Dir['test/**/*']
  s.homepage      = 'https://github.com/tlewin/helmet'  
  s.license       = 'MIT'

  s.add_dependency 'goliath'
  s.add_dependency 'http_router'
  s.add_dependency 'tilt'

  s.add_development_dependency 'yard'
  s.add_development_dependency 'shoulda'
end