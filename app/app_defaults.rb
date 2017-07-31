class AppDefaults

  class << self
    def load_defaults
      App::Persistence['width']               ||= 1280
      App::Persistence['height']              ||= 720
      App::Persistence['debug']               ||= false
      App::Persistence['jump_height']         = 12
      App::Persistence['duration_multiplier'] ||= 0.02
      App::Persistence['ground_ends_game']    ||= false
      App::Persistence['speed']               ||= 1.5 
      App::Persistence['pipe_distance']       = 2000
      App::Persistence['gravity']             = -1.0
      mp 'set defaults'
    end

    def reset_to_default
      App::Persistence.all.each do |e|
        App::Persistence[e[0]] = nil
      end
      load_defaults
      mp App::Persistence.all
    end

  end
end
