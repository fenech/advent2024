{
  inc = $2 - $1 > 0
  for (i = 2; i < NF; i++) {
    if (inc && $(i+1) - $i  <= 0) next
    if ($(i+1) - $i >= 0) next
  }
  c++
}

END {
  print c
}
