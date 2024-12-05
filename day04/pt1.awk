BEGIN {
  FS = ""
}

{
  for (i = 1; i <= NF; i++) {
    c[NR][i] = $i
    if ($i == "X") start[NR,i]
  }
}

END {
  for (k in start) {
    split(k, a, SUBSEP)
    y = a[1]
    x = a[2]
    print x, y
    for (j = -1; j <= +1; ++j) {
      for (i = -1; i <= 1; ++i) {
        m = 0
        for (k = 1; k <= 3; ++k) {
          if (c[y+j*k][x+i*k] == substr("MAS", k, 1)) m++
        }
        if (m == 3) s++
      }
    }
  }
  print substr("MAS", 3, 1)
  print s
}
