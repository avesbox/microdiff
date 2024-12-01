/// Sealed family to represent the differences between two objects.
///
/// The differences are represented by the following classes:
/// - [CreateDifference]: Represents the creation of a new element in an array or object.
/// - [RemoveDifference]: Represents the removal of an element from an array or object.
/// - [ChangeDifference]: Represents the change of an element in an array or object.
///
/// Every difference has a [type], a [path] and a [value].
abstract class Difference {
  /// The type of the difference.
  final DifferenceType type;

  /// The path to the element that has changed.
  final List<dynamic> path;

  /// The new value of the element.
  final dynamic value;

  /// Creates a new difference with the given [type], [path] and [value].
  Difference(this.type, this.path, this.value);

  @override
  String toString() => '$runtimeType{type: $type, path: $path, value: $value}';
}

/// Represents the creation of a new element in an array or object.
class CreateDifference extends Difference {
  /// Creates a new create difference with the given [path] and [value].
  CreateDifference(List<dynamic> path, dynamic value)
      : super(DifferenceType.create, path, value);
}

/// Represents the removal of an element from an array or object.
class RemoveDifference extends Difference {
  /// Creates a new remove difference with the given [path] and [value].
  RemoveDifference(List<dynamic> path, dynamic value)
      : super(DifferenceType.remove, path, value);
}

/// Represents the change of an element in an array or object.
///
/// The difference contains the old value of the element.
class ChangeDifference extends Difference {
  /// The old value of the element.
  final dynamic oldValue;

  /// Creates a new change difference with the given [path], [value] and [oldValue].
  ChangeDifference(List<dynamic> path, dynamic value, this.oldValue)
      : super(DifferenceType.change, path, value);

  @override
  String toString() =>
      '$runtimeType{type: $type, path: $path, value: $value, oldValue: $oldValue}';
}

/// Enum to represent the type of a difference.
enum DifferenceType {
  /// Represents the creation of a new element in an array or object.
  create,

  /// Represents the removal of an element from an array or object.
  remove,

  /// Represents the change of an element in an array or object.
  change
}

/// Compares two objects and returns a list of differences between them.
///
/// The function compares the two objects and returns a list of differences between them.
/// It uses recursion to compare nested objects and a stack to keep track of the current differences.
List<Difference> diff(Object obj, Object newObj,
    {List<Difference> stack = const []}) {
  final differences = <Difference>[];
  if (obj is! Map<String, dynamic> && obj is! List) {
    throw ArgumentError('obj must be a Map<String, dynamci> or List');
  }

  if (newObj is! Map<String, dynamic> && newObj is! List) {
    throw ArgumentError('newObj must be a Map<String, dynamic> or List');
  }

  final isObjArray = obj is List;
  final isNewObjArray = newObj is List;

  final entries = ((isObjArray ? (obj).asMap() : obj) as Map).entries;

  for (final entry in entries) {
    final key = entry.key;
    final objValue = entry.value;
    if ((isNewObjArray && newObj.length <= (key as int)) ||
        (!isNewObjArray && !(newObj as Map).containsKey(key))) {
      differences.add(RemoveDifference([key], entry.value));
      continue;
    }
    dynamic getNewObjValue() {
      if (isNewObjArray && newObj.length > (key as int)) {
        return newObj[key];
      } else if (!isNewObjArray) {
        return (newObj as Map)[key];
      } else {
        return null;
      }
    }

    final newObjValue = getNewObjValue();
    if (newObjValue == null) {
      differences.add(ChangeDifference([key], objValue, null));
      continue;
    }
    final areCompatibleObj = (objValue is Map<String, dynamic> &&
            newObjValue is Map<String, dynamic>) ||
        (objValue is List && newObjValue is List);
    if (areCompatibleObj) {
      differences.addAll(diff(objValue, newObjValue, stack: stack)
          .map((diff) => diff..path.insert(0, key)));
    } else if (objValue != newObjValue) {
      differences.add(ChangeDifference([key], newObjValue, objValue));
    }
  }
  final newObjEntries =
      ((isNewObjArray ? (newObj).asMap() : newObj) as Map).entries;
  for (final entry in newObjEntries) {
    final key = entry.key;
    if ((isObjArray && obj.length <= (key as int)) ||
        (!isObjArray && !(obj as Map).containsKey(key))) {
      differences.add(CreateDifference([key], entry.value));
    }
  }
  return differences;
}
