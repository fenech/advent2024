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
  px = $3 + 10000000000000
  py = $5 + 10000000000000

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

  if (sprintf("%.2f", x) ~ /00$/ && sprintf("%.2f", y) ~ /00$/) sum += 3 * x + y
}

END {
  print sum
}
