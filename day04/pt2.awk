BEGIN {
  FS = ""
}

{
  for (i = 1; i <= NF; i++) {
    c[NR][i] = $i
    if ($i == "A") start[NR,i]
  }
}

END {
  for (k in start) {
    split(k, a, SUBSEP)
    y = a[1]
    x = a[2]

    if (c[y-1][x-1] == "M" && c[y+1][x+1] == "S" || c[y-1][x-1] == "S" && c[y+1][x+1] == "M") {
      if (c[y+1][x-1] == "M" && c[y-1][x+1] == "S" || c[y+1][x-1] == "S" && c[y-1][x+1] == "M") s++
    }

    if (c[y-1][x] == "M" && c[y+1][x] == "S" || c[y-1][x] == "S" && c[y+1][x] == "M") {
      if (c[y][x-1] == "M" && c[y][x-1] == "S" || c[y][x-1] == "S" && c[y][x-1] == "M") s++
    }
  }
  print s
}
