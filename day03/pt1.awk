BEGIN {
  FPAT = "mul\\([1-9][0-9]{0,2},[1-9][0-9]{0,2}\\)"
}

{
  for (i = 1; i <= NF; i++) {
    a = substr($i, 5, index($i, ",") - 5)
    b = substr($i, index($i, ",") + 1, length($i) - index($i, ",") - 1)
    sum += a * b
  }
}

END {
  print sum
}
