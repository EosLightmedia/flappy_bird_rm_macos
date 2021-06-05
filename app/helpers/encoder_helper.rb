class EncoderHelper
  
  def initialize 
    @last_position = 0
  end
  
  def spin_calc(data)
    #
    #so really all I want to do is bring in the value from the encoder and set the video position based on that and then snap to a point close to the video time...
    current_position = data
    
    mp "this is last position -- #{@last_position}"
    mp "this is current position -- #{current_position}"
    
    result = current_position - @last_position

    @last_position = current_position
    result

  end
  
  def video_scrub(to_add, current, max)
    if (current + to_add) >= max
      result = 0 + to_add
    else
      result = current + to_add
    end
  end
  
  def last_to_zero
  	@last_position = 0
  end
  
  # def convert_to_video_time(value_in)
 #
 #  end
 #
 #  def map(value,  istart,  istop, ostart, ostop)
 #    unless (istop - istart) == 0
 #      result = ostart + (ostop - ostart) * ((value - istart) / (istop - istart))
 #      result = ostop if result > ostop
 #      result = ostart if result < ostart
 #      result
 #    end
 #  end
    
end