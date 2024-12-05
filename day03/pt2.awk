BEGIN {
  FPAT = "mul\\([1-9][0-9]{0,2},[1-9][0-9]{0,2})|do\\()|don't\\()"
}

{
  for (i = 1; i <= NF; i++) {
    if ($i == "don't()") {
      disabled = 1
      continue
    }
    if ($i == "do()") {
      disabled = 0
      continue
    }
    if (!disabled) {
      a = substr($i, 5, index($i, ",") - 5)
      b = substr($i, index($i, ",") + 1, length($i) - index($i, ",") - 1)
      sum += a * b
    }
  }
}

END {
  print sum
}
