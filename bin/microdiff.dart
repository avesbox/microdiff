import 'package:microdiff/microdiff.dart' as microdiff;

void main(List<String> arguments) {
  final value = microdiff.diff(
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
