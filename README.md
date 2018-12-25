# Play Dart

* mirror
* curry
* expand [TODO]

## Mirror

实现了一个json转model的类`Decodable`

## curry

实现了curry化函数

```dart
main() {
  final addCurry = curry(add);
  final res = addCurry(1)(2);
  print(res);
}
int add(int l, int r) {
  return l+r;
}
```