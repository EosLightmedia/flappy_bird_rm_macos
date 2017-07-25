class AppDelegate
  
  def applicationDidFinishLaunching(notification)
    @screen = Screen.alloc.init
    @win_size = [@screen.width, @screen.height]
    @win_frame = [[0,0], @win_size]
    buildMenu
    build_flappy_window
    @skeleton_data = {}
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
    start_osc_server
  end
  
  def start_osc_server
    @server = OSCServer.alloc.init
    @server.delegate = self
    @server.listen(7000)
    mp 'started server on port 7000'
  end
  
  def handleMessage(message)
    #USING NI_MATE TO SEND OSC DATA. USE ANIMATA JOINT STYLE
    # mp "got a message - #{message.arguments}" 
    if message.arguments.length == 0
      mp "empty message"
    else
      case message.arguments[0] 
      when 'Right_Hand_0'
        # mp "right hand x: #{message.arguments[1]}, y: #{message.arguments[2]}"
        @skeleton_data[:right_hand] = [message.arguments[1], message.arguments[2]]
      when 'Left_Hand_0'
        # mp "left hand x: #{message.arguments[1]}, y: #{message.arguments[2]}"
        @skeleton_data[:left_hand] = [message.arguments[1], message.arguments[2]]
      when 'Left_Shoulder_0'
        # mp "left Shoulder x: #{message.arguments[1]}, y: #{message.arguments[2]}"
        @skeleton_data[:left_shoulder] = [message.arguments[1], message.arguments[2]]
      when 'Right_Shoulder_0'
        # mp "Right Shoulder x: #{message.arguments[1]}, y: #{message.arguments[2]}"
        @skeleton_data[:right_shoulder] = [message.arguments[1], message.arguments[2]]
      when 'Pelvis_0'
        # mp "Right Shoulder x: #{message.arguments[1]}, y: #{message.arguments[2]}"
        @skeleton_data[:right_shoulder] = [message.arguments[1], message.arguments[2]]
      end
    end
    mp @skeleton_data
  end

  def window_options
 NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask
  end

  def applicationShouldTerminateAfterLastWindowClosed(sender)
    true
  end
  
end
