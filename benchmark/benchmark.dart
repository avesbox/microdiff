// Import BenchmarkBase class.
import 'dart:convert';
import 'dart:io';

import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:microdiff/microdiff.dart';

// Create a new benchmark by extending BenchmarkBase
class MicrodiffBenchmark extends BenchmarkBase {
  MicrodiffBenchmark() : super('Microdiff');

  Map<String, dynamic> original = {};
  Map<String, dynamic> changed = {};

  static void main() {
    MicrodiffBenchmark().report();
  }

  @override
  void run() {
    diff(original, changed);
  }

  @override
  void setup() {
    File file = File('data/data.json');
    final json = file.readAsStringSync();
    original = jsonDecode(json);
    changed = jsonDecode(json);
    changed['exclude'] = ['./src/app/og/*.{tsx}'];
    changed['conditions']['extend']['light'] = '';
  }

  @override
  void teardown() {}
}

void main() {
  // Run TemplateBenchmark
  MicrodiffBenchmark.main();
}
