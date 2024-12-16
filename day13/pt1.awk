BEGIN {
  FS = "[=:+,] *"
}

{
  line = NR % 4
}

line == 1 {
  x1 = $3
  y1 = $5
}

line == 2 {
  x2 = $3
  y2 = $5
}

line == 3 {
  px = $3
  py = $5

  if (x1 > y1) {
    f = px * y1 / x1
    g = x2 * y1 / x1

    y = (py - f) / (y2 - g)
    x = (f - g * y) / y1
  }
  else {
    f = py * x1 / y1
    g = y2 * x1 / y1

    y = (px - f) / (x2 - g)
    x = (f - g * y) / x1
  }

  print x, y, 3 * x + y

  if (x ~ /^[1-9][0-9]{0,2}$/ && y ~ /^[1-9][0-9]{0,2}$/) sum += 3 * x + y
}

END {
  print sum
}
