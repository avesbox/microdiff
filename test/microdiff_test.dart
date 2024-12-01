import 'package:microdiff/microdiff.dart';
import 'package:test/test.dart';

void main() {
  test(
      'diff should return a RemoveDifference when an element is removed from an array or an object',
      () {
    final obj = [1, 2, 3];
    final newObj = [1, 2];
    final differences = diff(obj, newObj);
    expect(differences.length, 1);
    expect(differences[0], isA<RemoveDifference>());
    final obj2 = {'a': 1, 'b': 2, 'c': 3};
    final newObj2 = {'a': 1, 'c': 3};
    final differences2 = diff(obj2, newObj2);
    expect(differences2.length, 1);
    expect(differences2[0], isA<RemoveDifference>());
  });

  test(
      'diff should return a ChangeDifference when an element has been changed in an array or an object',
      () {
    final obj = [1, 2, 3];
    final newObj = [1, 2, 4];
    final differences = diff(obj, newObj);
    expect(differences.length, 1);
    expect(differences[0], isA<ChangeDifference>());
    final obj2 = {'a': 1, 'b': 2, 'c': 3};
    final newObj2 = {'a': 1, 'b': 4, 'c': 3};
    final differences2 = diff(obj2, newObj2);
    expect(differences2.length, 1);
    expect(differences2[0], isA<ChangeDifference>());
  });

  test(
      'diff should return a CreateDifference when an element has been added to an array or an object',
      () {
    final obj = [1, 2];
    final newObj = [1, 2, 3];
    final differences = diff(obj, newObj);
    expect(differences.length, 1);
    expect(differences[0], isA<CreateDifference>());
    final obj2 = {'a': 1, 'b': 2};
    final newObj2 = {'a': 1, 'b': 2, 'c': 3};
    final differences2 = diff(obj2, newObj2);
    expect(differences2.length, 1);
    expect(differences2[0], isA<CreateDifference>());
  });
}
