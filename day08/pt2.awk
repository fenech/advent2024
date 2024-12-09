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
    n = split(an[i], arr, SUBSEP)
    for (j = 1; j <= n - 2; j += 2) {
      for (k = j + 2; k <= n; k += 2) {
        dx = arr[j] - arr[k]
        dy = arr[j+1] - arr[k+1]

        p[arr[j],arr[j+1]]
        p[arr[k],arr[k+1]]

        s = 0
        while (++s) {
          px = arr[j] + dx * s
          py = arr[j+1] + dy * s
          if (px > 0 && px <= NF && py > 0 && py <= NR) p[px,py]
          else break
        }

        s = 0
        while (++s) {
          px = arr[k] - dx * s
          py = arr[k+1] - dy * s
          if (px > 0 && px <= NF && py > 0 && py <= NR) p[px,py]
          else break
        }
      }
    }
  }
  print length(p)
}
