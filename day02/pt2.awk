{
  inc = 0
  dec = 0
  idx = 0
  for (i = 1; i < NF; i++) {
    diff = $(i+1) - $i
    if (diff > 0 && diff <= 3) inc++
    else if (diff < 0 && diff >= -3) dec++
  }

  if (inc == NF - 1 || dec == NF - 1) {
    c++
    next
  }
}

{
  line = $0

  for (r = 1; r <= NF; r++) {
    $0 = line
    $r = ""
    n = split($0, arr)

    inc = 0
    dec = 0
    for (i = 1; i < n; i++) {
      diff = arr[i+1] - arr[i]
      if (diff > 0 && diff <= 3) inc++
      else if (diff < 0 && diff >= -3) dec++
    }

    if (inc == n - 1 || dec == n - 1) {
      c++
      break
    }
  }
}

END {
  print c
}
