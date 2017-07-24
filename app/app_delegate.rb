class AppDelegate
  
  def applicationDidFinishLaunching(notification)
    @screen = Screen.alloc.init
    @win_size = [@screen.width, @screen.height]
    @win_frame = [[0,0], @win_size]
    buildMenu
    build_flappy_window
  end
  
  def build_flappy_window
    @mainWindow = NSWindow.alloc.initWithContentRect(@win_frame,
      styleMask: window_options,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.setLevel(NSScreenSaverWindowLevel - 2)
    @mainWindow.orderFrontRegardless

    view = CloudView.alloc.initWithFrame(@mainWindow.frame)
    @mainWindow.setContentView(view)
  end

  def window_options
    NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask
  end

  def applicationShouldTerminateAfterLastWindowClosed(sender)
    true
  end
  
end
