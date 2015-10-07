$:.push File.expand_path('../lib', __FILE__)
require 'js_tools/version'

Gem::Specification.new do |s|
  s.name        = 'js_tools'
  s.version     = JsTools::VERSION
  s.authors     = ['Khrebtov Roman']
  s.email       = ['roman@alltmb.ru']
  s.homepage    = 'https://github.com/Hrom512/js_tools'
  s.summary     = 'JS tools for rails'
  s.description = s.summary
  s.license     = 'MIT'

  s.files = Dir['{app,lib}/**/*', 'Gemfile', 'MIT-LICENSE', 'README.md']

  s.add_dependency 'rails', '>= 4.0'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'sass-rails'
end
