function manhattan(sx, sy, ex, ey) {
  dx = ex - sx
  if (dx < 0) dx = -dx
  dy = ey - sy
  if (dy < 0) dy = -dy
  return dx + dy
}

function a_star(sx, sy, ex, ey, wall) {
  q[sx,sy] = manhattan(sx, sy, ex, ey)
  g[sx,sy] = 0

  while (length(q)) {
    for (i in q) {
      split(i, a, SUBSEP)
      if (a[1] == ex && a[2] == ey) {
        return g[i]
      }

      delete q[i]

      delete tg
      if (a[2] > 0 && !((a[1],a[2]-1) in wall)) {
        tg[a[1],a[2]-1] = g[i] + 1
      }
      if (a[1] < 70 && !((a[1]+1,a[2]) in wall)) {
        tg[a[1]+1,a[2]] = g[i] + 1
      }
      if (a[2] < 70 && !((a[1],a[2]+1) in wall)) {
        tg[a[1],a[2]+1] = g[i] + 1
      }
      if (a[1] > 0 && !((a[1]-1,a[2]) in wall)) {
        tg[a[1]-1,a[2]] = g[i] + 1
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

BEGIN {
  PROCINFO["sorted_in"] = "@val_num_asc"
  FS = ","
}

NR <= 1024 {
  corrupt[$1,$2]
}

END {
  print a_star(0, 0, 70, 70, corrupt)
}
