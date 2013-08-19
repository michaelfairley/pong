class Paddle
  WIDTH = 16
  HEIGHT = 96

  attr_reader :side, :y
  def initialize(side)
    @side = side
    @y = Pong::HEIGHT/2
  end

  def x1
    case side
    when :left
      0
    when :right
      Pong::WIDTH - WIDTH
    end
  end

  def x2
    x1 + WIDTH
  end

  def y1
    y - HEIGHT/2
  end

  def y2
    y1 + HEIGHT
  end

  def draw(window)
    color = Gosu::Color::WHITE

    window.draw_quad(
      x1, y1, color,
      x1, y2, color,
      x2, y2, color,
      x2, y1, color,
    )
  end
end
