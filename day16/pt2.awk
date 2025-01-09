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

function a_star(sx, sy, ex, ey, skip) {
  delete q
  delete g
  delete seen
  q[sx,sy,1] = manhattan(sx, sy, ex, ey)
  g[sx,sy,1] = 0

  while (length(q)) {
    for (i in q) {
      split(i, a, SUBSEP)
      if (a[1] == ex && a[2] == ey) {
        p = i
        seen[a[1],a[2]]
        while (p != sx SUBSEP sy SUBSEP 1) {
          p = from[p]
          split(p, a, SUBSEP)
          seen[a[1],a[2]]
        }
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
        split(t, a, SUBSEP)
        if (a[1] SUBSEP a[2] == skip) {
          continue
        }
        if (!(t in g) || tg[t] < g[t]) {
          from[t] = i
          g[t] = tg[t]
          q[t] = g[t] + manhattan(a[1], a[2], ex, ey)
        }
      }
      break
    }
  }
  return -1
}

function bfs(sx, sy, ex, ey,   i, d, a) {
  q[sx,sy,1] = 0

  while (length(q)) {
    for (i in q) {
      if (seen[i]++) continue
      d = q[i]
      split(i, a, SUBSEP)
      if (a[1] == ex && a[2] == ey) {
        return a[3]
      }

      delete tg
      tg[a[1],a[2],(a[3]+1)%4] = d + 1000
      tg[a[1],a[2],(a[3]+3)%4] = d + 1000

      if (a[3] == 0 && !((a[1],a[2]-1) in wall)) {
        tg[a[1],a[2]-1,a[3]] = d + 1
      }
      else if (a[3] == 1 && !((a[1]+1,a[2]) in wall)) {
        tg[a[1]+1,a[2],a[3]] = d + 1
      }
      else if (a[3] == 2 && !((a[1],a[2]+1) in wall)) {
        tg[a[1],a[2]+1,a[3]] = d + 1
      }
      else if (a[3] == 3 && !((a[1]-1,a[2]) in wall)) {
        tg[a[1]-1,a[2],a[3]] = d + 1
      }

      for (t in tg) {
        if (!(t in q) || tg[t] < q[t]) {
          q[t] = tg[t]
        }
      }

      break
    }
  }
}

function dfs(sx, sy, ex, ey, dir, scores,  q, i, d, a) {
  PROCINFO["sorted_in"] = "@val_num_desc"

  q[ex,ey,dir] = scores[ex,ey,dir]

  while (length(q)) {
    for (i in q) {
      d = q[i]
      delete q[i]
      split(i, a, SUBSEP)
      path[a[1],a[2]]

      delete turn
      turn[a[1],a[2],(a[3]+1)%4]
      turn[a[1],a[2],(a[3]+3)%4]

      for (t in turn) {
        if (t in scores && scores[t] == d - 1000) q[t] = scores[t]
      }

      delete move
      if (a[3] == 2 && !((a[1],a[2]-1) in wall)) {
        move[a[1],a[2]-1,a[3]]
      }
      else if (a[3] == 3 && !((a[1]+1,a[2]) in wall)) {
        move[a[1]+1,a[2],a[3]]
      }
      else if (a[3] == 0 && !((a[1],a[2]+1) in wall)) {
        move[a[1],a[2]+1,a[3]]
      }
      else if (a[3] == 1 && !((a[1]-1,a[2]) in wall)) {
        move[a[1]-1,a[2],a[3]]
      }

      for (t in move) {
        if (t in scores && scores[t] == d - 1) q[t] = scores[t]
      }

      break
    }
  }
}

function print_grid(seen, i, j) {
  for (j = 1; j <= NR; ++j) {
    for (i = 1; i <= NF; ++i) {
      printf "%s%s",
        ((i,j) in seen || (i,j,0) in seen || (i,j,1) in seen || (i,j,2) in seen || (i,j,3) in seen ? "O" :
          ((i,j) in wall ? "#" :
            (i == sx && j == sy ? "S" :
              (i == ex && j == ey ? "E" : ".")))),
        (i < NF ? OFS : ORS)
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
  dir = bfs(sx, sy, ex, ey)
  dfs(sx, sy, ex, ey, dir, q)
  print length(path)
  print_grid(path)
}
