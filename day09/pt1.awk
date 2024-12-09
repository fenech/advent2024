BEGIN {
  FS = ""
}

{
  b = 0
  for (i = 1; i <= NF; ++i) {
    if (i % 2) {
      for (n = 1; n <= $i; ++n) {
        disk[++p] = b
      }
      lens[b] = $i
      ++b
    }
    else {
      for (n = 1; n <= $i; ++n) {
        gaps[++g] = p + n
      }
      p += $i
    }
  }
}

END {
  # for (i = 1; i <= p; ++i) {
  #   printf "%s", (i in disk ? disk[i] : ".")
  # }
  # print ""

  n = asorti(disk, blocks, "@val_num_asc")

  for (i = 1; i <= g && gaps[i] < blocks[n]; ++i) {
    disk[gaps[i]] = disk[blocks[n]]
    delete disk[blocks[n]]
    n--

    # for (j = 1; j <= p; ++j) {
    #   printf "%s", (j in disk ? disk[j] : ".")
    # }
    # print ""
  }

  # for (i = 1; i <= p; ++i) {
  #   printf "%s", (i in disk ? disk[i] : ".")
  # }
  # print ""

  for (i = 0; i < length(disk); ++i) checksum += i * disk[i+1]
  print checksum
}
