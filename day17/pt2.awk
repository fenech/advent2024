BEGIN {
  FS = ":* |,"
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

function join(array, start, end, sep,    result, i)
{
    if (sep == "")
       sep = " "
    else if (sep == SUBSEP) # magic value
       sep = ""
    result = array[start]
    for (i = start + 1; i <= end; i++)
        result = result sep array[i]
    return result
}

function dfs(ops,    idx, q, out, n, pfx, a, arr, solution) {
  PROCINFO["sorted_in"] = "@val_num_desc"

  q[0] = 0
  idx = length(ops)
  while (length(q)) {
    for (i in q) {
      d = q[i]
      delete q[i]

      n = split(i, arr, SUBSEP)
      if (n - 1 == idx) {
        solution = strtonum("0" join(arr, 1, n, SUBSEP))
        min = min == "" || solution < min ? solution : min
      }

      pfx = join(arr, 1, n, SUBSEP)

      for (t = 0; t < 8; t++) {
        a = strtonum("0" pfx t)
        out = program(ops, a)
        if (out == ops[idx - d - 1]) {
          q[i,t] = d + 1
        }
      }
      break
    }
  }

  return solution
}

function program(ops, a, idx,    a_init, b, c, len, i, ins, op, out, n) {
  a_init = a
  b = 0
  c = 0
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
  return out[1]
}

/Program/ {
  for (i = 2; i <= NF; i++) {
    ops[i - 2] = $i
  }

  print dfs(ops)
}
