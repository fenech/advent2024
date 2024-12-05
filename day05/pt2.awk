BEGIN {
  FS = "|"
}

!NF && ++skip {
  FS = ","
  next
}

!skip {
  rules[$1,$2] = 1
  next
}

{
  ordered = 1
  for (i = 1; i < NF; ++i) {
    for (j = i + 1; j <= NF; ++j) {
      if (!rules[$i,$j]) {
        ordered = 0
        if (rules[$j,$i]) {
          t = $i
          $i = $j
          $j = t
        }
      }
    }
  }
  if (!ordered) sum += $((NF+1)/2)
}

END {
  print sum
}
