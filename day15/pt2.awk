BEGIN {
  FS = ""
}

NF && !c {
  w = 2 * NF + 1
  h = NR
}

!NF {
  c = 1
}

function in_box(x, y) {
  return (x,y) in lbox || (x,y) in rbox
}

!c {
  for (i = 1; i <= NF; ++i) {
    if ($i == "#") {
      wall[2*i,NR]
      wall[2*i+1,NR]
    }
    else if ($i == "O") {
      lbox[2*i,NR]
      rbox[2*i+1,NR]
    }
    else if ($i == "@") {
      rx = 2*i
      ry = NR
    }
  }
  next
}

{
  for (f = 1; f <= NF; ++f) {
    print $f
    delete q
    delete ml
    delete mr
    if ($f == "<") {
      for (i = rx - 1; in_box(i,ry); i--) {
        if ((i,ry) in lbox) ml[i]
        if ((i,ry) in rbox) mr[i]
      }
      if ((i,ry) in wall) continue
      rx--
      for (i in ml) {
        delete lbox[i,ry]
      }
      for (i in ml) {
        lbox[i-1,ry]
      }
      for (i in mr) {
        delete rbox[i,ry]
      }
      for (i in mr) {
          rbox[i-1,ry]
      }
    }
    else if ($f == ">") {
      for (i = rx + 1; in_box(i,ry); i++) {
        if ((i,ry) in lbox) ml[i]
        if ((i,ry) in rbox) mr[i]
      }
      if ((i,ry) in wall) continue
      rx++
      for (i in ml) {
        delete lbox[i,ry]
      }
      for (i in ml) {
        lbox[i+1,ry]
      }
      for (i in mr) {
        delete rbox[i,ry]
      }
      for (i in mr) {
        rbox[i+1,ry]
      }
    }
    else if ($f == "^") {
      hit = 0
      q[rx,ry]
      while (!hit && length(q)) {
        for (i in q) {
          split(i, a, SUBSEP)
          x = a[1]
          y = a[2]
          delete q[i]
          if ((x,y-1) in wall) {
            hit = 1
            break
          }
          if ((x,y-1) in lbox) {
            ml[x,y-1]
            mr[x+1,y-1]
            q[x,y-1]
            q[x+1,y-1]
          }
          else if ((x,y-1) in rbox) {
            ml[x-1,y-1]
            mr[x,y-1]
            q[x-1,y-1]
            q[x,y-1]
          }
          break
        }
      }
      if (!hit) {
        for (i in ml) {
          delete lbox[i]
        }
        for (i in ml) {
          split(i, a, SUBSEP)
          x = a[1]
          y = a[2]
          lbox[x,y-1]
        }
        for (i in mr) {
          delete rbox[i]
        }
        for (i in mr) {
          split(i, a, SUBSEP)
          x = a[1]
          y = a[2]
          rbox[x,y-1]
        }
        ry--
      }
    }
    else if ($f == "v") {
      hit = 0
      q[rx,ry]
      while (!hit && length(q)) {
        for (i in q) {
          split(i, a, SUBSEP)
          x = a[1]
          y = a[2]
          delete q[i]
          if ((x,y+1) in wall) {
            hit = 1
            break
          }
          if ((x,y+1) in lbox) {
            ml[x,y+1]
            mr[x+1,y+1]
            q[x,y+1]
            q[x+1,y+1]
          }
          else if ((x,y+1) in rbox) {
            ml[x-1,y+1]
            mr[x,y+1]
            q[x-1,y+1]
            q[x,y+1]
          }
          break
        }
      }
      if (!hit) {
        for (i in ml) {
          delete lbox[i]
        }
        for (i in ml) {
          split(i, a, SUBSEP)
          x = a[1]
          y = a[2]
          lbox[x,y+1]
        }
        for (i in mr) {
          delete rbox[i]
        }
        for (i in mr) {
          split(i, a, SUBSEP)
          x = a[1]
          y = a[2]
          rbox[x,y+1]
        }
        ry++
      }
    }
    # for (y = 1; y <= h; ++y) {
    #   for (x = 1; x <= w; ++x) {
    #     printf "%s%s", ((x,y) in wall ? "#" : ((x,y) in lbox ? "[" : ((x,y) in rbox ? "]" : (x == rx && y == ry ? "@" : ".")))), (x < w ? OFS : ORS)
    #   }
    # }
  }
}

END {
  for (y = 1; y <= h; ++y) {
    for (x = 1; x <= w; ++x) {
      printf "%s%s", ((x,y) in wall ? "#" : ((x,y) in lbox ? "[" : ((x,y) in rbox ? "]" : (x == rx && y == ry ? "@" : ".")))), (x < w ? OFS : ORS)
    }
  }
  for (i in lbox) {
    split(i, a, SUBSEP)
    sum += 100 * (a[2] - 1) + a[1] - 2
  }
  print sum
}
