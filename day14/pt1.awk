BEGIN {
  FS = "p=|,| v=|"
  w = 101
  h = 103
  t = 100
}

{
  x = ($2 + t * $4) % w
  if (x < 0) x += w
  y = ($3 + t * $5) % h
  if (y < 0) y += h

  robots[x,y]++
}

END {
  for (j = 0; j < h; ++j) {
    for (i = 0; i < w; ++i) {
      printf "%s%s", ((i,j) in robots ? robots[i,j] : "."), (i < w - 1 ? OFS : ORS)

      if ((i,j) in robots) {
        if      (i < (w - 1) / 2 && j < (h - 1) / 2) q1 += robots[i,j]
        else if (i < (w - 1) / 2 && j > (h - 1) / 2) q2 += robots[i,j]
        else if (i > (w - 1) / 2 && j < (h - 1) / 2) q3 += robots[i,j]
        else if (i > (w - 1) / 2 && j > (h - 1) / 2) q4 += robots[i,j]
      }
    }
  }
  print q1 * q2 * q3 * q4
}
