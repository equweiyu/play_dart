import 'dart:mirrors';

abstract class Decodable {
  Decodable.decode(dynamic data) {
    final classMirror = reflectClass(this.runtimeType);
    final mirror = reflect(this);

    classMirror.declarations.values.forEach((f) {
      if (f is VariableMirror) {
        final keySymbol = f.simpleName;
        final key = MirrorSystem.getName(keySymbol);
        var value = data[key];
        final type = (f.type.reflectedType);
        final typeClass = reflectClass(type);

        if (typeClass.isSubclassOf(reflectClass(List))) {
          final _ = f.type.reflectedType.toString();
          final itemTypeName = _.substring(5, _.length - 1);
          final itemClass = findClassMirror(itemTypeName);
          if (itemClass.isSubclassOf(reflectClass(Decodable))) {
            mirror.setField(
                keySymbol,
                (value as List)
                    .map((f) => itemClass.newInstance(#decode, [f]).reflectee)
                    .toList());
          } else {
            mirror.setField(keySymbol, value);
          }
        } else {
          if (typeClass.isSubtypeOf(reflectClass(Decodable))) {
            mirror.setField(
                keySymbol, typeClass.newInstance(#decode, [value]).reflectee);
          } else {
            mirror.setField(keySymbol, value);
          }
        }
      }
    });
  }
}

ClassMirror findClassMirror(String name) {
  for (var lib in currentMirrorSystem().libraries.values) {
    var mirror = lib.declarations[MirrorSystem.getSymbol(name)];
    if (mirror != null) return mirror;
  }
  throw new ArgumentError("Class $name does not exist");
}
