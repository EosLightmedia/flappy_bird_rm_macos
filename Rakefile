# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require "motion/project/template/osx"

begin
  require "bundler"
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.name = "flappy"
  app.frameworks += ["SpriteKit", "GameController"]
  # app.interface_orientations = [:portrait]
end