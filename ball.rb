class Ball
  SIZE = 16

  attr_reader :x, :y, :angle, :speed
  def initialize
    @x = Pong::WIDTH/2
    @y = Pong::HEIGHT/2

    @angle = rand(120) + 30
    @angle *= -1  if rand > 0.5
    @speed = 6
  end

  def dx; Gosu.offset_x(angle, speed); end
  def dy; Gosu.offset_y(angle, speed); end

  def move!
    @x += dx
    @y += dy

    if @y < 0
      @y = 0
      bounce_off_edge!
    end

    if @y > Pong::HEIGHT
      @y = Pong::HEIGHT
      bounce_off_edge!
    end
  end

  def bounce_off_edge!
    @angle = Gosu.angle(0, 0, dx, -dy)
  end

  def x1; @x - SIZE/2; end
  def x2; @x + SIZE/2; end
  def y1; @y - SIZE/2; end
  def y2; @y + SIZE/2; end

  def draw(window)
    color = Gosu::Color::RED

    window.draw_quad(
      x1, y1, color,
      x1, y2, color,
      x2, y2, color,
      x2, y1, color,
    )
  end

  def off_left?
    x1 < 0
  end

  def off_right?
    x2 > Pong::WIDTH
  end

  def intersect?(paddle)
    x1 < paddle.x2 &&
      x2 > paddle.x1 &&
      y1 < paddle.y2 &&
      y2 > paddle.y1
  end

  def bounce_off_paddle!(paddle)
    case paddle.side
    when :left
      @x = paddle.x2 + SIZE/2
    when :right
      @x = paddle.x1 - SIZE/2
    end

    ratio = (y - paddle.y) / Paddle::HEIGHT
    @angle = ratio * 120 + 90
    @angle *= -1  if paddle.side == :right

    @speed *= 1.1
  end
end
