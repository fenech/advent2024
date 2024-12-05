{
  a[$1]++
  b[$2]++
}

END {
  for (i in a) {
    sum += i * a[i] * b[i]
  }

  print sum
}
