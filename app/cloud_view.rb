class CloudView < SKView
  def initWithFrame(frame)
    super
    # enable_debug

    self.presentScene(new_cloud_scene)
  end

  def new_cloud_scene
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
