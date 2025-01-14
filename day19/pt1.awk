BEGIN {
  FS = ", "
}

NR == 1 {
  re = "^("
  for (i = 1; i <= NF; i++) {
    re = re $i (i < NF ? "|" : "")
  }
  re = re ")+$"
  print re
  next
}

NF && $0 ~ re {
  m++
}

END {
  print m
}
