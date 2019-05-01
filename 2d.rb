# Methods taken from some code I previously figured out:
# https://gist.github.com/JoshCheek/91576bb7a13397679fdbf49452a021c2
require 'matrix'

module TwoD
  include Math

  def point(x, y)
    Matrix[[x], [y], [1]]
  end

  def translate(x, y)
    Matrix[
      [1, 0, x],
      [0, 1, y],
      [0, 0, 1]
    ]
  end

  def scale(x, y)
    Matrix[
      [x, 0, 0],
      [0, y, 0],
      [0, 0, 1]
    ]
  end

  def rotate(radians)
    Matrix[
      [cos(radians), -sin(radians), 0],
      [sin(radians),  cos(radians), 0],
      [           0,             0, 1],
    ]
  end

  def shear(x, y)
    Matrix[
      [1, x, 0],
      [y, 1, 0],
      [0, 0, 1],
    ]
  end
end
