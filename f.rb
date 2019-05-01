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
    veins_per_segment = 10


    num_segments      = 3
    num_rings         = 4
    veins_per_segment = 3

    num_veins         = veins_per_segment * num_segments
    num_dots          = num_veins * num_rings

    time        = 1  # second
    radius      = 5  # pixels
    translation = 10 # pixels

    num_dots.times do |dot_index|
      segment_percent =
        (dot_index % veins_per_segment).to_f / veins_per_segment

      vein_percent = # of segment
        (dot_index % num_veins).to_f / num_veins

      ring_index =
        (dot_index / num_veins)

      pt =
        translate(w/2, h/2) * # move to middle of the screen
          point(translation, 0)

      x = pt[0,0]
      y = pt[1,0]
      # circle x, y, radius, :white
    end

    dot translate(w/2, h/2) * # move to middle of the screen
        point(translation, 0)

    dot translate(w/2, h/2) * # move to middle of the screen
        rotate(PI/2) *        # rotate
        point(translation, 0)


    # transform:
    #   rotate(calc(var(--ring-index)*5deg + var(--vein-percent)*1turn))
    #   translate(calc(8em + var(--ring-index)*1em))
    #   rotate(0deg)
    #   translate($translation)

    	# --pos:
    	# 	rotate(calc(var(--ring-index)*5deg + var(--vein-percent)*1turn))
    	# 	translate(calc(8em + var(--ring-index)*1em));
    	# transform: var(--pos) rotate(0deg) translate($translation);
    # 	box-shadow: inset 0 0 5px 2px hsl(calc(var(--vein-percent)*360), 100%, 75%);
    # 	animation: a $time linear calc(var(--segment-percent)*#{-$time}) infinite

    # @keyframes a {
    # 	to {
    # 		transform: var(--pos) rotate(1turn) translate($translation)
    # 	}
    # }
  end

  def dot(position)
    radius = 5
    circle position[0,0], position[1,0], radius, :white
  end

  new.run
end
