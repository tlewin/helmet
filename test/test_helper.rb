require 'test/unit'
require 'goliath/test_helper'

require File.join(File.dirname(__FILE__), '..', 'lib', 'helmet', 'api')

# STDOUT.puts "File dirname: #{File.dirname(__FILE__)}"
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

Goliath.env = :test