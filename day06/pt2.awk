BEGIN {
  FS = ""
  dx = 0
  dy = 0
}

{
  for (i = 1; i <= NF; ++i) {
    if ($i == "#") {
      obs[i,NR]
    }
    else if ($i ~ /[v^><]/) {
      sx = x = i
      sy = y = NR
      if ($i == "^") {
        dy = -1
      }
      else if ($i == "v") {
        dy = 1
      }
      else if ($i == "<") {
        dx = -1
      }
      else if ($i == ">") {
        dx = 1
      }
      sdx = dx
      sdy = dy
    }
  }
}

END {
  while (x > 0 && x <= NF && y > 0 && y <= NR) {
    seen[x,y]
    x += dx
    y += dy
    if (x SUBSEP y in obs) {
      hit[x,y]
      x -= dx
      y -= dy
      corner[x,y]
      t = dx
      dx = -dy
      dy = t
    }
  }

  for (j = 1; j <= NR; ++j) {
    for (i = 1; i <= NF; ++i) {
      idx = i SUBSEP j
      printf "%s%s", (idx in corner ? "+" : (idx in seen ? "X" : (idx in obs ? "#" : "."))), (i < NF ? "" : ORS)
    }
  }

  print length(seen)

  for (s in seen) {
    if (s == sx SUBSEP sy) continue
    obs[s]

    x = sx
    y = sy
    dx = sdx
    dy = sdy

    delete loop
    while (x > 0 && x <= NF && y > 0 && y <= NR) {
      if (x SUBSEP y SUBSEP dx SUBSEP dy in loop) {
        count++
        break
      }

      loop[x,y,dx,dy]
      x += dx
      y += dy
      if (x SUBSEP y in obs) {
        x -= dx
        y -= dy
        t = dx
        dx = -dy
        dy = t
      }
    }
    delete obs[s]
  }

  print count
}
