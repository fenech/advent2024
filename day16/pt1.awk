BEGIN {
  PROCINFO["sorted_in"] = "@val_num_asc"
  FS = ""
}

function manhattan(sx, sy, ex, ey) {
  dx = ex - sx
  if (dx < 0) dx = -dx
  dy = ey - sy
  if (dy < 0) dy = -dy
  return dx + dy
}

function a_star(sx, sy, ex, ey) {
  q[sx,sy,1] = manhattan(sx, sy, ex, ey)
  g[sx,sy,1] = 0

  while (length(q)) {
    for (i in q) {
      split(i, a, SUBSEP)
      if (a[1] == ex && a[2] == ey) {
        return g[i]
      }

      delete q[i]

      delete tg
      tg[a[1],a[2],(a[3]+1)%4] = g[i] + 1000
      tg[a[1],a[2],(a[3]+3)%4] = g[i] + 1000
      if (a[3] == 0 && !((a[1],a[2]-1) in wall)) {
        tg[a[1],a[2]-1,a[3]] = g[i] + 1
      }
      else if (a[3] == 1 && !((a[1]+1,a[2]) in wall)) {
        tg[a[1]+1,a[2],a[3]] = g[i] + 1
      }
      else if (a[3] == 2 && !((a[1],a[2]+1) in wall)) {
        tg[a[1],a[2]+1,a[3]] = g[i] + 1
      }
      else if (a[3] == 3 && !((a[1]-1,a[2]) in wall)) {
        tg[a[1]-1,a[2],a[3]] = g[i] + 1
      }

      for (t in tg) {
        if (!(t in g) || tg[t] < g[t]) {
          from[t] = i
          g[t] = tg[t]
          split(t, a, SUBSEP)
          q[t] = g[t] + manhattan(a[1], a[2], ex, ey)
        }
      }
      break
    }
  }
}

{
  for (i = 1; i <= NF; ++i) {
    if ($i == "#") wall[i,NR]
    else if ($i == "S") {
      sx = i
      sy = NR
    }
    else if ($i == "E") {
      ex = i
      ey = NR
    }
  }
}

END {
  print sx, sy, ex, ey
  print a_star(sx, sy, ex, ey)
}
