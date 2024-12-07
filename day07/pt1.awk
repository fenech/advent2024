BEGIN {
  FS = ":* "
}

{
  target = $1
  delete opt
  n = 1
  opt[n++] = $2
  for (i = 3; i <= NF; i++) {
    for (o in opt) {
      curr = opt[o]
      delete opt[o]
      if (curr + $i <= target) opt[n++] = curr + $i
      if (curr * $i <= target) opt[n++] = curr * $i
    }
  }
  for (o in opt) {
    if (opt[o] == target) {
      sum += $1
      next
    }
  }
}

END {
  print sum
}
