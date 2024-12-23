BEGIN {
  FS = "p=|,| v=|"
  w = 101
  h = 103
  t = 100
}

{
  px[NR] = $2
  py[NR] = $3
  vx[NR] = $4
  vy[NR] = $5
}

END {
  t = 6869
  while (++t < 17280) {
    #printf "\033[2J\033[H"

    delete robots
    for (i = 1; i <= NR; ++i) {
      x = (px[i] + t * vx[i]) % w
      if (x < 0) x += w
      y = (py[i] + t * vy[i]) % h
      if (y < 0) y += h

      robots[x,y]++
    }

    out = ""
    q1 = q2 = q3 = q4 = 0
    for (j = 0; j < h; ++j) {
      for (i = 0; i < w; ++i) {
        out = out sprintf("%s%s", ((i,j) in robots ? robots[i,j] : "."), (i < w - 1 ? OFS : ORS))

        if ((i,j) in robots) {
          if      (i < (w - 1) / 2 && j < (h - 1) / 2) q1 += robots[i,j]
          else if (i < (w - 1) / 2 && j > (h - 1) / 2) q2 += robots[i,j]
          else if (i > (w - 1) / 2 && j < (h - 1) / 2) q3 += robots[i,j]
          else if (i > (w - 1) / 2 && j > (h - 1) / 2) q4 += robots[i,j]
        }
      }
    }
    print out
    break
    if ((q1 * q2 * q3 * q4) == 96623280) {
      print t
     # break
    }

    print out
    #print t, (q1 * q2 * q3 * q4)
    #print t, (q1 * q2 * q3 * q4) > "data"
  }
}
