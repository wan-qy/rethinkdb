#!/usr/bin/env ruby
# Copyright 2010-2014 RethinkDB, all rights reserved.

expectedDriverPath = File.join(File.dirname(__FILE__), 'lib')

# -- load the driver

$LOAD_PATH.unshift(expectedDriverPath)
require 'rethinkdb'
$LOAD_PATH.shift
include RethinkDB::Shortcuts

# -- test that we got the driver we expected

actualDirverPath = File.dirname(r.method(:connect).source_location[0])
if actualDirverPath != expectedDriverPath
  abort "Wrong Ruby driver loaded, expected from: " + expectedDriverPath + " but got :" + actualDirverPath
end

# --

$port_offset = ENV['PORT_OFFSET'].to_i
$c = r.connect(:host => 'localhost', :port => $port_offset + 28015, :db => 'test').repl
