C Function(B) Function(A) curry<A, B, C>(C Function(A, B) function) {
  return (a) => (b) => function(a, b);
}