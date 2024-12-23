BEGIN {
  FS = ""
}

{
  for (x = 1; x <= NF; ++x) {
    f[x,NR] = $x
  }
}

END {
  for (x = 1; x <= NF; ++x) {
    for (y = 1; y <= NR; ++y) {
      if ((x, y) in seen) continue
      t = f[x,y]

      delete area
      delete q
      area[x,y]
      q[x,y]
      while (length(q)) {
        #print length(q), area, peri, t
        for (p in q) {
          seen[p]

          split(p, a, SUBSEP)
          i = a[1]
          j = a[2]
          delete q[p]
          if (!((i-1,j) in seen) && (i-1,j) in f && f[i-1,j] == t) {
            q[i-1,j]
            area[i-1,j]
          }
          if (!((i+1,j) in seen) && (i+1,j) in f && f[i+1,j] == t) {
            q[i+1,j]
            area[i+1,j]
          }
          if (!((i,j+1) in seen) && (i,j+1) in f && f[i,j+1] == t) {
            q[i,j+1]
            area[i,j+1]
          }
          if (!((i,j-1) in seen) && (i,j-1) in f && f[i,j-1] == t) {
            q[i,j-1]
            area[i,j-1]
          }
          break
        }
      }

      peri = 0
      for (p in area) {
        peri += 4
        split(p, a, SUBSEP)
        i = a[1]
        j = a[2]
        if ((i-1,j) in area) peri--
        if ((i+1,j) in area) peri--
        if ((i,j+1) in area) peri--
        if ((i,j-1) in area) peri--
      }
      print t, length(area), peri
      sum += length(area) * peri
    }
  }
  print sum
}
