BEGIN {
  FS = ""
}

{
  for (i = 1; i <= NF; ++i) {
    map[i,NR] = $i
    if ($i == 0) {
      th[i,NR]
    }
    else if ($i == 9) {
      pp[i,NR]
    }
  }
}

END {
  for (p in th) {
    delete seen
    split(p, a, SUBSEP)
    sx = a[1]
    sy = a[2]
    q[sx,sy]

    while (length(q)) {
      for (k in q) {
        delete q[k]

        split(k, a, SUBSEP)
        x = a[1]
        y = a[2]
        #print x, y, map[x,y]

        j = 0
        for (i = -1; i <= 1; i += 2) {
          if ((x+i,y+j) in map && map[x+i,y+j] == map[x,y] + 1) {
            if (map[x,y] == 8) {
              print x+i, y+j, map[x+i,y+j]
              seen[x+i,y+j]
            }
            else {
              q[x+i,y+j]
            }
          }
        }

        i = 0
        for (j = -1; j <= 1; j += 2) {
          if ((x+i,y+j) in map && map[x+i,y+j] == map[x,y] + 1) {
            if (map[x,y] == 8) {
              print x+i, y+j, map[x+i,y+j]
              seen[x+i,y+j]
            }
            else {
              q[x+i,y+j]
            }
          }
        }
        break
      }
    }
    score += length(seen)
  }
  print score
}
