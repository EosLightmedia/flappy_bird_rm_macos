class Screen
  attr_accessor :width, :height

  def initialize
    @width = App::Persistence['width'].to_i
    @height = App::Persistence['height'].to_i
  end
  
end
