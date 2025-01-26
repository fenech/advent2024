BEGIN {
  PROCINFO["sorted_in"] = "@val_num_asc"
  FS = ""
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

function manhattan(sx, sy, ex, ey) {
  dx = ex - sx
  if (dx < 0) dx = -dx
  dy = ey - sy
  if (dy < 0) dy = -dy
  return dx + dy
}

function a_star(sx, sy, ex, ey, wall,    q) {
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
      if (a[1] < NF && !((a[1]+1,a[2]) in wall)) {
        tg[a[1]+1,a[2]] = g[i] + 1
      }
      if (a[2] < NF && !((a[1],a[2]+1) in wall)) {
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
  print "no"
  exit
}

function print_grid() {
  for (j = 1; j <= NR; ++j) {
    for (i = 1; i <= NF; ++i) {
      printf "%02d%s", ((i,j) in track ? track[i,j] : ((i,j) in wall ? "#" : ".")), (i < NF ? OFS : ORS)
    }
  }
}


END {
  d = a_star(sx, sy, ex, ey, wall)
  print "d", d

  track[ex,ey] = d
  p = ex SUBSEP ey
  while (p != sx SUBSEP sy) {
    p = from[p]
    track[p] = g[p]
  }

  min = 100

  for (p in track) {
    c = track[p]
    split(p, a, SUBSEP)
    x = a[1]
    y = a[2]
    if ((x+2,y) in track && track[x+2,y] - c > min + 1) {
      cheat++
    }
    if ((x-2,y) in track && track[x-2,y] - c > min + 1) {
      cheat++
    }
    if ((x,y+2) in track && track[x,y+2] - c > min + 1) {
      cheat++
    }
    if ((x,y-2) in track && track[x,y-2] - c > min + 1) {
      cheat++
    }
  }

  print cheat
}
