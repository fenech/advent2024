NR == 1 {
  for (i = 1; i <= NF; ++i) {
    stones[$i]++
  }
}

END {
  for (b = 1; b <= 75; ++b) {
    for (i in stones) {
      if (stones[i] + 0 == 0) continue
      if (i + 0 == 0) {
        s[1] += stones[i]
        stones[i] = 0
        continue
      }
      digits = length(i)
      if (digits % 2 == 0) {
        s[substr(i, 1, digits / 2) + 0] += stones[i]
        s[substr(i, digits / 2 + 1) + 0] += stones[i]
        stones[i] = 0
        continue
      }
      s[i*2024] += stones[i]
      stones[i] = 0
    }
    for (i in s) {
      stones[i] += s[i]
    }
    delete s
  }

  for (i in stones) {
    if (stones[i]) count += stones[i]
  }
  print count
}
