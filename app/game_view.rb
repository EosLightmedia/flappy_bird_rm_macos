class GameView < SKView
  def initWithFrame(frame)
    super
    enable_debug if App::Persistence['debug']
                     
    self.presentScene(new_bird_scene)
  end

  def new_bird_scene
    scene = SkyLineScene.sceneWithSize(self.frame.size)
    scene.scaleMode = SKSceneScaleModeResizeFill
    scene
  end

  def enable_debug
    self.showsFPS = true
    self.showsNodeCount = true
    self.showsDrawCount = true
  end
end
