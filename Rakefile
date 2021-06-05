# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
$:.unshift("~/.rubymotion/rubymotion-templates")

require 'motion/project/template/osx'

begin
  require "bundler"
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.name = "flappy"
  app.frameworks += ["SpriteKit", "GameController"]
  app.icon = 'eos_black'
  app.deployment_target = '10.10'
  app.identifier = 'com.eoslightmedia.flappy_bird'
  app.copyright = 'Copyright © 2017 Eos Lightmedia Corporation. All rights reserved.'
  app.codesign_for_release = false
  
  #Phidget Support
  app.embedded_frameworks += ['/Library/Frameworks/Phidget22.framework']
  app.bridgesupport_files << 'resources/phidget22.bridgesupport'
  app.vendor_project('./vendor/phidget22', :static)
  
  app.pods do
    pod 'OSCKit'
  end
end
