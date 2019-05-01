# Trying to draw this:
# https://codepen.io/thebabydino/pen/MRdqry
require_relative '2d'
require 'graphics'

class Image < Graphics::Simulation
  include TwoD

  def initialize
    super 800, 600
    color.default_proc = -> _, k { k }
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
    distance    = 30 # pixels
    vein_radius = 120

    turn = 2*PI

    deg = lambda do |n|
      turn * n/360
    end

    dot = lambda do |position, color|
      circle position[0,0], position[1,0], radius, color
    end

    num_dots.times do |dot_index|
      vein_index              = dot_index % num_veins
      ring_index              = dot_index / num_veins
      segment_index           = vein_index / veins_per_segment
      vein_in_segment_index   = vein_index % veins_per_segment
      vein_in_segment_percent = vein_in_segment_index.to_f / veins_per_segment
      vein_percent            = vein_index.to_f / num_veins

      animation_percent = (
        seconds + (vein_in_segment_percent * duration)
      ) % duration

      pt = translate(w/2, h/2) * # move to middle of the screen
           rotate(ring_index*deg[5] + vein_percent*turn) *
           translate(vein_radius + ring_index*distance, 0) *
           rotate(animation_percent*turn) *
           point(distance, 0)

      dot[pt, hsl(vein_percent*360, 1.0, 0.75)]
    end

  end

  # https://www.rapidtables.com/convert/color/hsl-to-rgb.html
  def hsl(hue, saturation, lightness)
    c = (1 - (2*lightness - 1).abs) * saturation
    x = c * (1 - ((hue/60.0) % 2 - 1).abs)
    m = lightness - c/2
    case hue % 360
    when   0 ...  60 then r_prime, g_prime, b_prime = c, x, 0
    when  60 ... 120 then r_prime, g_prime, b_prime = x, c, 0
    when 120 ... 180 then r_prime, g_prime, b_prime = 0, c, x
    when 180 ... 240 then r_prime, g_prime, b_prime = 0, x, c
    when 240 ... 300 then r_prime, g_prime, b_prime = x, 0, c
    when 300 ... 360 then r_prime, g_prime, b_prime = c, 0, x
    end
    r = (r_prime+m)*255
    g = (g_prime+m)*255
    b = (b_prime+m)*255
    a = 255 # opaque
    renderer.format.map_rgba r.round, g.round, b.round, 255
  end

  new.run
end
