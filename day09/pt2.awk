BEGIN {
  FS = ""
}

{
  b = 0
  for (i = 1; i <= NF; ++i) {
    if (i % 2) {
      start[b] = p + 1
      lens[b] = $i

      for (n = 0; n < $i; ++n) {
        disk[start[b] + n] = b
      }
      ++b
      p += $i

    }
    else {
      gaps[p + 1] = $i
      p += $i
    }
  }
}

END {
  for (i = 1; i <= p; ++i) {
    printf "%s", (i in disk ? disk[i] : ".")
  }
  print ""

  n = asorti(start, sk, "@ind_num_asc")
  m = asorti(gaps, gk, "@ind_num_asc")

  for (i = n; i >= 1; --i) {
    for (g = 1; g <= m; ++g) {
      if (!(gk[g] in gaps)) continue
      file = start[sk[i]]
      len = lens[sk[i]]
      gs = gk[g]
      gap = gaps[gs]
      if (file + 0 < gs + 0) {
        break
      }
      if (len + 0 <= gap + 0) {
        start[sk[i]] = gk[g]
        if (gaps[gs] + 0 > 0) {
          gaps[gs + len] = gaps[gs] - len
          gk[g] = gs + len
        }
        delete gaps[gs]
        break
      }
    }
  }

  for (i in start) {
    for (j = 0; j < lens[i]; ++j) {
      defrag[start[i]+j] = i
    }
  }

  for (i = 1; i <= p; ++i) {
    printf "%s", (i in defrag ? defrag[i] : ".")
    if (i in defrag) checksum += defrag[i] * (i-1)
  }
  print ""
  print checksum
}
