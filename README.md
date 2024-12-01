# Microdiff

Microdiff is fast, zery dependency object and array comparison library. It is a Dart porting of [microdiff](https://github.com/AsyncBanana/microdiff).

## Features

- 🚀 Fast
- 💙 Easy to use, you need to simply call the `diff` function

## Usage

```dart
import 'package:microdiff/microdiff.dart';

void main() {
  final diff = diff([1, 2, 3], [1, 2, 4]);
  print(diff);
}
```

## Get started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  microdiff: ^1.0.0
```

Or you can install it from the command line:

```bash
dart pub add microdiff
```

## License
