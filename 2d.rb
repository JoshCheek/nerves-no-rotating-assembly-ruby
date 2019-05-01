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
    radians *= -1
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
