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
    # rotate(PI/2) * point(1, 0)

    num_segments      = 3
    num_rings         = 7
    veins_per_segment = 15

    num_veins         = veins_per_segment * num_segments
    num_dots          = num_veins * num_rings

    time        = 1  # second
    radius      = 5  # pixels
    translation = 10 # pixels

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

      pt =
        translate(w/2, h/2) * # move to middle of the screen
          rotate(
            ring_index * 2*PI * 5/360 +
            vein_percent * 2*PI
          ) *
          translate(
            (1+num_rings)*translation +
              ring_index*translation,
            0
          ) *
          rotate(0) *
          point(translation, 0)

      dot[pt]
    end

    # box-shadow: inset 0 0 5px 2px hsl(calc(var(--vein-percent)*360), 100%, 75%);
    # --pos:
    # 	rotate(calc(var(--ring-index)*5deg + var(--vein-percent)*1turn))
    # 	translate(calc(8em + var(--ring-index)*1em));
    # transform: var(--pos) rotate(0deg) translate($translation);
    # animation: a $time linear calc(var(--segment-percent)*#{-$time}) infinite

    # @keyframes a {
    # 	to {
    # 		transform: var(--pos) rotate(1turn) translate($translation)
    # 	}
    # }
  end

  new.run
end
