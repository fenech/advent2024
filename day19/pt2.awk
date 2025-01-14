BEGIN {
  FS = ", "
}

NR == 1 {
  for (i = 1; i <= NF; i++) {
    towels[i] = $i
  }
  n = NF
  next
}

NF {
  PROCINFO["sorted_in"] = "@val_num_desc"

  design = $1
  q[""] = design

  while (length(q)) {
    for (i in q) {
      remaining = q[i]
      delete q[i]

      if (remaining == "") {
        m++
      }

      for (j = 1; j <= n; ++j) {
        towel = towels[j]
        if (substr(remaining, 1, length(towel)) == towel) {
          r = substr(remaining, length(towel) + 1)
          q[i,towel] = r
        }
      }
    }
  }
}

END {
  print m
}
