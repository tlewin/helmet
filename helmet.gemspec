require './lib/helmet/version'

Gem::Specification.new do |s|
  s.name          = 'helmet'
  s.version       = Helmet::VERSION
  s.date          = Time.now
  s.summary       = 'Simple web framework for Goliath web server.'
  s.description   = s.summary
  s.authors       = ['Thiago Lewin']
  s.email         = 'thiago_lewin@yahoo.com.br'
  s.files         = Dir['{lib/**/*,example/**/*,test/**/*}']
  s.homepage      = 'https://github.com/tlewin/helmet'  

  s.add_dependency 'goliath'
  s.add_dependency 'http_route'
  s.add_dependency 'tilt'

  s.add_development_dependency 'yard'
  s.add_development_dependency 'shoulda'
end