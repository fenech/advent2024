BEGIN {
  FS = ""
}

{
  for (i = 1; i <= NF; ++i) {
    if ($i != ".") {
      if ($i in an) an[$i] = an[$i] SUBSEP
      an[$i] = an[$i] i SUBSEP NR
    }
  }
}

END {
  for (i in an) {
    print i
    n = split(an[i], arr, SUBSEP)
    for (j = 1; j <= n - 2; j += 2) {
      for (k = j + 2; k <= n; k += 2) {
        dx = arr[j] - arr[k]
        dy = arr[j+1] - arr[k+1]

        px = arr[j]+dx
        py = arr[j+1]+dy
        if (px > 0 && px <= NF && py > 0 && py <= NR) p[px,py]

        px = arr[k]-dx
        py = arr[k+1]-dy
        if (px > 0 && px <= NF && py > 0 && py <= NR) p[px,py]
      }
    }
  }
  print length(p)
}
