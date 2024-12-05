{
  a[NR] = $1
  b[NR] = $2
}

END {
  na = asort(a)
  nb = asort(b)

  for (i = 1; i <= na; i++) {
    diff = a[i] - b[i]
    if (diff < 0) diff *= -1
    sum += diff
  }

  print sum
}
