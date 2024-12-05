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
  for (i = 1; i < NF; ++i) {
    for (j = i + 1; j <= NF; ++j) {
      if (!rules[$i,$j]) next
    }
  }
  sum += $((NF+1)/2)
}

END {
  print sum
}
