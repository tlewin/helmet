Gem::Specification.new do |s|
  s.name          = 'helmet'
  s.version       = '0.0.3'
  s.date          = '2012-09-14'
  s.summary       = 'Simple web framework for Goliath web server.'
  s.description   = s.summary
  s.authors       = ['Thiago Lewin']
  s.email         = 'thiago_lewin@yahoo.com.br'
  s.files         = Dir['{lib/**/*,example/*}']
  s.homepage      = 'https://github.com/tlewin/helmet'  
  s.add_dependency 'goliath'
  s.add_dependency 'tilt'
end