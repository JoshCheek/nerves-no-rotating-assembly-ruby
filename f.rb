# Trying to draw this:
# https://codepen.io/thebabydino/pen/MRdqry
require_relative '2d'
require 'graphics'

class Image < Graphics::Simulation
  include TwoD

  TURN = -2*PI
  DEG  = TURN/360

  def initialize
    super 800, 600
    color.default_proc = -> _, k { k }
  end

  def draw(n)
    clear :black

    @start_time ||= Time.now
    time = Time.now - @start_time

    duration    = 1
    radius      = 5
    distance    = 20
    vein_radius = 120

    num_segments      = 3
    num_rings         = 7
    veins_per_segment = 15
    num_veins         = veins_per_segment * num_segments
    num_dots          = num_veins * num_rings

    num_dots.times do |dot_index|
      vein_index              = dot_index % num_veins
      ring_index              = dot_index / num_veins
      vein_in_segment_index   = vein_index % veins_per_segment
      vein_in_segment_percent = vein_in_segment_index.to_f / veins_per_segment
      vein_percent            = vein_index.to_f / num_veins

      animation_percent = (
        time + (vein_in_segment_percent * duration)
      ) / duration

      point =
        translate(w/2, h/2)                             * # move to middle of the screen
        rotate(ring_index*5*DEG + vein_percent*TURN)    * # ring index_makes the vein curve, vein_percent rotates the vein into place
        translate(vein_radius + ring_index*distance, 0) * # move the point to it's distance from the center
        rotate(animation_percent*TURN)                  * # each vein offset rotates the same
        point(distance, 0)                                # start the given distance out

      color = hsl(vein_percent*360, 1.0, 0.75) # colour each vein the same

      circle point[0,0], point[1,0], radius, color
    end
  end

  # formula taken from
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
