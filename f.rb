# Trying to draw this:
# https://codepen.io/thebabydino/pen/MRdqry
require_relative '2d'
require 'graphics'

class Image < Graphics::Simulation
  include TwoD

  def initialize
    super 800, 600
  end

  def draw(n)
    clear :black

    @start_time ||= Time.now
    seconds = Time.now - @start_time

    num_segments      = 3
    num_rings         = 7
    veins_per_segment = 15

    num_veins         = veins_per_segment * num_segments
    num_dots          = num_veins * num_rings

    duration    = 1  # seconds
    radius      = 5  # pixels
    vein_radius = radius*8
    distance    = 10 # pixels

    turn = 2*PI

    deg = lambda do |n|
      turn * n/360
    end

    dot = lambda do |position|
      circle position[0,0], position[1,0], radius, :white
    end


    num_dots.times do |dot_index|
      vein_index              = dot_index % num_veins
      ring_index              = dot_index / num_veins
      segment_index           = vein_index / veins_per_segment
      vein_in_segment_index   = vein_index % veins_per_segment
      vein_in_segment_percent = vein_in_segment_index.to_f / veins_per_segment
      vein_percent            = vein_index.to_f / num_veins

      animation_percent = (
        seconds + (vein_in_segment_percent * -duration)
      ) % duration

      pt = translate(w/2, h/2) * # move to middle of the screen
           rotate(ring_index*deg[5] + vein_percent*turn) *
           translate(vein_radius + ring_index*distance, 0) *
           rotate(animation_percent*turn) *
           point(distance, 0)

      dot[pt]
    end

    # box-shadow: inset 0 0 5px 2px hsl(calc(var(--vein-percent)*360), 100%, 75%);
  end

  new.run
end
