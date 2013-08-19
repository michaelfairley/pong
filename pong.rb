require "bundler/setup"
require "hasu"

Hasu.load "ball.rb"

class Pong < Hasu::Window
  WIDTH = 768
  HEIGHT = 576

  def initialize
    super(WIDTH, HEIGHT, false)
  end

  def reset
    @ball = Ball.new

    @left_score = 0
    @right_score = 0

    @font = Gosu::Font.new(self, "Arial", 30)
  end

  def draw
    @ball.draw(self)

    @font.draw(@left_score, 30, 30, 0)
    @font.draw(@right_score, WIDTH-50, 30, 0)
  end

  def update
    @ball.move!

    if @ball.off_left?
      @right_score += 1
      @ball = Ball.new
    end

    if @ball.off_right?
      @left_score += 1
      @ball = Ball.new
    end
  end
end

Pong.run
