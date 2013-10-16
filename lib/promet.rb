# coding: utf-8
require "bundler/setup"
require "promet/version"
require "httparty"
require "json"

module Promet
end


require "promet/geo_space"

if defined? RUBY_ENGINE && RUBY_ENGINE == 'jruby'
  require "promet/jruby_decoder"
else
  require "promet/mri_decoder"
end
