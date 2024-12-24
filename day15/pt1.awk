BEGIN {
  FS = ""
}

NF && !c {
  w = NF
  h = NR
}

!NF {
  c = 1
}

!c {
  for (i = 1; i <= NF; ++i) {
    if ($i == "#") wall[i,NR]
    else if ($i == "O") box[i,NR]
    else if ($i == "@") {
      rx = i
      ry = NR
    }
  }
  next
}

{
  for (f = 1; f <= NF; ++f) {
    delete push
    if ($f == "<") {
      for (i = rx - 1; (i,ry) in box; i--) {
        push[i]
      }
      if ((i,ry) in wall) continue
      if (length(push)) {
        delete box[rx-1,ry]
        box[i,ry]
      }
      rx--
    } else if ($f == ">") {
      for (i = rx + 1; (i,ry) in box; i++) {
        push[i]
      }
      if ((i,ry) in wall) continue
      if (length(push)) {
        delete box[rx+1,ry]
        box[i,ry]
      }
      rx++
    } else if ($f == "^") {
      for (i = ry - 1; (rx,i) in box; i--) {
        push[i]
      }
      if ((rx,i) in wall) continue
      if (length(push)) {
        delete box[rx,ry-1]
        box[rx,i]
      }
      ry--
    } else if ($f == "v") {
      for (i = ry + 1; (rx,i) in box; i++) {
        push[i]
      }
      if ((rx,i) in wall) continue
      if (length(push)) {
        delete box[rx,ry+1]
        box[rx,i]
      }
      ry++
    }

    # for (y = 1; y <= h; ++y) {
    #   for (x = 1; x <= w; ++x) {
    #     printf "%s%s", ((x,y) in wall ? "#" : ((x,y) in box ? "O" : ".")), (x < w ? OFS : ORS)
    #   }
    # }
  }
}

END {
  for (i in box) {
    split(i, a, SUBSEP)
    sum += 100 * (a[2] - 1) + a[1] - 1
  }
  print sum
}
