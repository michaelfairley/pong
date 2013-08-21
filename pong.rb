require "bundler/setup"
require "hasu"

Hasu.load "ball.rb"
Hasu.load "paddle.rb"

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

    @left_paddle = Paddle.new(:left, true)
    @right_paddle = Paddle.new(:right)
  end

  def draw
    @ball.draw(self)

    @font.draw(@left_score, 30, 30, 0)
    @font.draw(@right_score, WIDTH-50, 30, 0)

    @left_paddle.draw(self)
    @right_paddle.draw(self)
  end

  def update
    @ball.move!

    if @left_paddle.ai?
      @left_paddle.ai_move!(@ball)
    else
      if button_down?(Gosu::KbW)
        @left_paddle.up!
      end
      if button_down?(Gosu::KbS)
        @left_paddle.down!
      end
    end
    if button_down?(Gosu::KbUp)
      @right_paddle.up!
    end
    if button_down?(Gosu::KbDown)
      @right_paddle.down!
    end

    if @ball.intersect?(@left_paddle)
      @ball.bounce_off_paddle!(@left_paddle)
    end
    if @ball.intersect?(@right_paddle)
      @ball.bounce_off_paddle!(@right_paddle)
    end

    if @ball.off_left?
      @right_score += 1
      @ball = Ball.new
    end

    if @ball.off_right?
      @left_score += 1
      @ball = Ball.new
    end
  end

  def button_down(button)
    case button
    when Gosu::KbEscape
      close
    end
  end
end

Pong.run
