class AppDelegate
  
  PHIDGET_IP = '192.168.1.141'
  PHIDGET_SERIAL_NUMBER = -1
  
  
  def applicationDidFinishLaunching(notification)
    AppDefaults.load_defaults
		$center = NSNotificationCenter.defaultCenter 
    @screen = Screen.alloc.init
    @win_size = [@screen.width, @screen.height]
    @win_frame = [[0,0], @win_size]
    buildMenu
    build_flappy_window
    @skeleton_data = {:right_hand => [0,0], :left_hand => [0,0], :right_shoulder => [0,0], :right_hip => [0,0]}
    @hand_status = 0
    
    #adding phidget control in
    @old_value = 0
    @old_position = 0
    @e_helper = EncoderHelper.new
    setup_listeners
    setup_phidgets
    
  end
  
  def build_flappy_window
    @mainWindow = NSWindow.alloc.initWithContentRect(@win_frame,
      styleMask: window_options,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.setLevel(NSScreenSaverWindowLevel - 2)
    @mainWindow.orderFrontRegardless

    view = GameView.alloc.initWithFrame(@mainWindow.frame)
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
  
  def setup_listeners
    #Phidgets Notification Posting
    @center = NSNotificationCenter.defaultCenter
    @center.addObserver(self, selector: 'phidget_attached:', name: 'phidget_attached', object: nil)
    @center.addObserver(self, selector: 'process_position:', name: 'phidget_position_change', object: nil)
    @center.addObserver(self, selector: 'process_state:', name: 'phidget_state_change_from_encoder', object: nil) 
    @center.addObserver(self, selector: 'process_button:', name: 'phidget_state_change_from_button', object: nil) 
  end
  
  def setup_phidgets
    mp 'Setting up Phidgets'
    @phidget = EncoderController.new.startEncoder(PHIDGET_SERIAL_NUMBER, port: 1, channel: 0, serverName: 'Vint 1', ip: PHIDGET_IP, networkPort: 5661)
    #shaun only has an old controller....
    #@phidget = PhidgetEncoderController.new.createEncoder(-1)
    
    @phidget_button = EncoderInputController.new.startEncoderInput(PHIDGET_SERIAL_NUMBER, port: 2, channel: 0, serverName: 'Vint 1', ip: PHIDGET_IP, networkPort: 5661)
    @phidget_2 = DigitalInputController.new.startDigitalInput(PHIDGET_SERIAL_NUMBER, port: 3, channel: 0, serverName: 'Vint 1', ip: PHIDGET_IP, networkPort: 5661)
  end
  
  #this is called when the phidget 'attaches' to the system (available for talking to)
	def phidget_attached(notification)
		value = notification.userInfo
    mp "Phidget #{value["serial"]} with #{value["port"]} at #{value["channel"]} attached (in AppDelegate)"
    # sleep(1) #wait for the phidget to get ready to accept calls. May not need this.
    @phidget_attached = true #this is useful so you dont' write to a phidget which isn't there
	end
  
	def process_detach(notification)
	  value = notification.userInfo
    # sleep(1) #wait for the phidget to get ready to accept calls. May not need this.
    @phidget_attached = false
    mp "Phidget Detatched!! PANIC!!"
	end
  
  def process_button(notification)
    # go_home
  end
  
  def process_position(notification)
    value = notification.userInfo    
    converted_value = "#{value["position"]}".to_i
    mp "Position is #{value["position"]} and converted value is #{converted_value}"
    step = @e_helper.spin_calc(converted_value)
    mp "#{step} -----------"
    $center.postNotificationName('encoder_notification', object:self, userInfo:step)
  end

  def window_options
 NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask
  end

  def applicationShouldTerminateAfterLastWindowClosed(sender)
    true
  end
  
end
