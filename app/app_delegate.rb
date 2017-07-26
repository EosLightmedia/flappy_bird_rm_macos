class AppDelegate
  
  def applicationDidFinishLaunching(notification)
		$center = NSNotificationCenter.defaultCenter 
    @screen = Screen.alloc.init
    @win_size = [@screen.width, @screen.height]
    @win_frame = [[0,0], @win_size]
    buildMenu
    build_flappy_window
    @skeleton_data = {:right_hand => [0,0], :left_hand => [0,0], :right_shoulder => [0,0], :right_hip => [0,0]}
    @hand_status = 0
  end
  
  def build_flappy_window
    @mainWindow = NSWindow.alloc.initWithContentRect(@win_frame,
      styleMask: window_options,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.setLevel(NSScreenSaverWindowLevel - 2)
    @mainWindow.orderFrontRegardless

    view = BirdView.alloc.initWithFrame(@mainWindow.frame)
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
    # mp "got a message - #{message.address},#{message.arguments}" 
    if message.arguments.length == 0
      mp "empty message"
    else
      case message.address
      when 'Right_Hand_1'
        # mp "right hand x: #{message.arguments[1]}, y: #{message.arguments[2]}"
        @skeleton_data[:right_hand] = [message.arguments[1], message.arguments[2]]
      when 'Left_Hand_1'
        # mp "left hand x: #{message.arguments[1]}, y: #{message.arguments[2]}"
        @skeleton_data[:left_hand] = [message.arguments[1], message.arguments[2]]
      when 'Left_Shoulder_1'
        # mp "left Shoulder x: #{message.arguments[1]}, y: #{message.arguments[2]}"
        @skeleton_data[:left_shoulder] = [message.arguments[1], message.arguments[2]]
      when 'Right_Shoulder_1'
        # mp "Right Shoulder x: #{message.arguments[1]}, y: #{message.arguments[2]}"
        @skeleton_data[:right_shoulder] = [message.arguments[1], message.arguments[2]]
      when 'Right_Hip_1'
        # mp "Right Shoulder x: #{message.arguments[1]}, y: #{message.arguments[2]}"
        @skeleton_data[:right_hip] = [message.arguments[1], message.arguments[2]]
      when 'Torso_1'
        # mp "Right Shoulder x: #{message.arguments[1]}, y: #{message.arguments[2]}"
        @skeleton_data[:torso] = [message.arguments[1], message.arguments[2]]
      end
      # mp @skeleton_data
      # mp @skeleton_data[:right_hand][0]
      if @skeleton_data[:right_hand][0] > @skeleton_data[:right_shoulder][0]
        # mp "THE HAND IS HIGHER THAN THE SHOULDER"
        if @hand_status == 0
          $center.postNotificationName('command_notification', object:self, userInfo:nil)
          @hand_status = 1
          mp 'should be flapping'
        end
      end
      if @skeleton_data[:right_hand][0] < @skeleton_data[:right_hip][0]
        # mp "THE HAND IS lower THAN THE hip"
        @hand_status = 0
      end
    end
  end

  def window_options
 NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask
  end

  def applicationShouldTerminateAfterLastWindowClosed(sender)
    true
  end
  
end
