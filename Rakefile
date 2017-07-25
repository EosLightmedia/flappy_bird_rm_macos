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
  app.icon = 'eos_black'
  app.identifier = 'com.eoslightmedia.flappy_bird'
  app.copyright = 'Copyright © 2017 Eos Lightmedia Corporation. All rights reserved.'
  app.codesign_for_release = false
  
  app.pods do
    pod 'OSCKit'
  end
end
