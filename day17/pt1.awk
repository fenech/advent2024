BEGIN {
  FS = ":* |,"
  OFS = ","
}

/A:/ {
  a = $3
}

/B:/ {
  b = $3
}

/C:/ {
  c = $3
}

function combo(i, a, b, c) {
  if (i >= 0 && i < 4) return i
  if (i == 4) return a
  if (i == 5) return b
  if (i == 6) return c
}

function program(ops, a, b, c,     len, i, ins, op, out, n) {
  len = length(ops)
  for (i = 0; i < len; i += 2) {
    ins = ops[i]
    op = ops[i+1]

    if (ins == 0) {
      a = int(a / 2 ** combo(op, a, b, c))
    }
    else if (ins == 1) {
      b = xor(b, op)
    }
    else if (ins == 2) {
      b = combo(op, a, b, c) % 8
    }
    else if (ins == 3 && a != 0) {
      i = op - 2
    }
    else if (ins == 4) {
      b = xor(b, c)
    }
    else if (ins == 5) {
      out[++n] = combo(op, a, b, c) % 8
    }
    else if (ins == 6) {
      b = int(a / 2 ** combo(op, a, b, c))
    }
    else if (ins == 7) {
      c = int(a / 2 ** combo(op, a, b, c))
    }
  }
  for (i = 1; i <= n; ++i) {
    printf "%s%s", out[i], (i < n ? OFS : ORS)
  }
}


/Program/ {
  for (i = 2; i <= NF; i++) {
    ops[i-2] = $i
  }

  program(ops, a, b, c)
}
