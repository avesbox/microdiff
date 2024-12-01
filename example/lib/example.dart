import 'package:microdiff/microdiff.dart';

void main(List<String> arguments) {
  final value = diff(
    [
      1,
      2,
      [1, 2, 3, 4],
      4
    ],
    List<Object>.from([1, 2, 3]),
  );
  print(value);
}