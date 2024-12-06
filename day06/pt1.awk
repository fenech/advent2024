BEGIN {
  FS = ""
  dx = 0
  dy = 0
}

{
  for (i = 1; i <= NF; ++i) {
    if ($i == "#") {
      obs[i,NR] = 1
    }
    else if ($i ~ /[v^><]/) {
      x = i
      y = NR
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
    }
  }
}

END {
  while (x > 0 && x <= NF && y > 0 && y <= NR) {
    seen[x,y]
    x += dx
    y += dy
    if (obs[x,y]) {
      x -= dx
      y -= dy
      t = dx
      dx = -dy
      dy = t
    }
  }
  print length(seen)
}
